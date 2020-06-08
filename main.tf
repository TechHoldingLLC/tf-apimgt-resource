resource "azurerm_api_management_api" "api" {
  name                = var.name
  resource_group_name = var.resource_group.name
  api_management_name = var.apimgt.name
  revision            = var.revision
  display_name        = var.display_name
  path                = var.path
  protocols           = ["https"]

  subscription_key_parameter_names {
    header = var.subscription_key_parameters.header
    query  = var.subscription_key_parameters.query
  }
}

resource "azurerm_api_management_api_operation" "api" {
  operation_id        = var.method_id
  api_name            = azurerm_api_management_api.api.name
  api_management_name = var.apimgt.name
  resource_group_name = var.resource_group.name
  display_name        = var.method_name
  method              = var.method
  url_template        = var.url
}

resource "azurerm_api_management_api_operation_policy" "api" {
  api_name            = azurerm_api_management_api.api.name
  api_management_name = var.apimgt.name
  resource_group_name = var.resource_group.name
  operation_id        = azurerm_api_management_api_operation.api.operation_id

  xml_content = <<XML
<policies>
  <inbound>
    <set-backend-service base-url="${var.backend.url}" />
  </inbound>
  <backend>
    <forward-request />
  </backend>
</policies>
XML
}

### PRODUCT


resource "azurerm_api_management_product_api" "api" {
  for_each = var.products

  api_name            = azurerm_api_management_api.api.name
  product_id          = each.value
  api_management_name = var.apimgt.name
  resource_group_name = var.resource_group.name
}
