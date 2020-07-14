resource "azurerm_api_management_api_version_set" "api" {
  name                = var.name
  resource_group_name = var.rg
  api_management_name = var.apim
  display_name        = var.display_name
  versioning_scheme   = var.versioning_scheme
}

resource "azurerm_api_management_api" "api" {
  for_each = var.versions

  name                = "${var.name}-${each.key}"
  resource_group_name = var.rg
  api_management_name = var.apim
  revision            = var.revision
  display_name        = "${var.display_name} ${each.key}"
  path                = each.value.path
  protocols           = ["https"]

  subscription_required = var.subscription_required
  subscription_key_parameter_names {
    header = each.value.subscription_key_parameter_names.header
    query  = each.value.subscription_key_parameter_names.query
  }

  version        = each.key
  version_set_id = azurerm_api_management_api_version_set.api.id
}

# resource "azurerm_api_management_api_policy" "api" {
#   for_each = local.versions_policy

#   api_name            = "${var.name}-${each.key}"
#   api_management_name = var.apim
#   resource_group_name = var.rg

#   xml_content = <<XML
# <policies>
#   <inbound>
#     ${each.value.inbound ? each.value.inbound : ""}
#   </inbound>
#   <backend>
#     ${each.value.backend ? each.value.backend : ""}
#   </backend>
#   <outbound>
#     ${each.value.outbound ? each.value.outbound : ""}
#   </outbound>
#   <on-error>
#     ${each.value.on_error ? each.value.on_error : ""}
#   </on-error>
# </policies>
# XML
# }

resource "azurerm_api_management_api_operation" "api" {
  for_each = local.routes

  resource_group_name = var.rg
  api_management_name = var.apim

  api_name     = lookup(azurerm_api_management_api.api, each.value.version, "").name
  operation_id = each.value.operation_id
  display_name = each.value.display_name
  method       = each.value.method
  url_template = each.value.src
}

resource "azurerm_api_management_api_operation_policy" "api" {
  for_each = local.routes_policy

  resource_group_name = var.rg
  api_management_name = var.apim

  api_name     = lookup(azurerm_api_management_api.api, each.value.version, "").name
  operation_id = lookup(azurerm_api_management_api_operation.api, each.key, "").operation_id

  xml_content = <<XML
<policies>
  <inbound>
    ${each.value.policy.inbound ? each.value.policy.inbound : ""}
  </inbound>
  <backend>
    ${each.value.policy.backend ? each.value.policy.backend : ""}
  </backend>
  <outbound>
    ${each.value.policy.outbound ? each.value.policy.outbound : ""}
  </outbound>
  <on-error>
    ${each.value.policy.on_error ? each.value.policy.on_error : ""}
  </on-error>
</policies>
XML
}

resource "azurerm_api_management_product_api" "api" {
  for_each = local.products

  resource_group_name = var.rg
  api_management_name = var.apim

  api_name   = lookup(azurerm_api_management_api.api, each.value.version, "").name
  product_id = each.value.product
}
