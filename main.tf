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

  subscription_key_parameter_names {
    header = each.value.subscription_key_parameter_names.header
    query  = each.value.subscription_key_parameter_names.query
  }

  version        = each.key
  version_set_id = azurerm_api_management_api_version_set.api.id
}

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
  for_each = local.routes

  resource_group_name = var.rg
  api_management_name = var.apim

  api_name     = lookup(azurerm_api_management_api.api, each.value.version, "").name
  operation_id = each.value.operation_id

  xml_content = <<XML
<policies>
  <inbound>
    <set-backend-service base-url="${each.value.dst}" />
  </inbound>
  <backend>
    <forward-request />
  </backend>
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
