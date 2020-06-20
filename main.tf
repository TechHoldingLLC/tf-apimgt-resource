resource "azurerm_api_management_api_version_set" "api" {
  name                = var.name
  resource_group_name = var.rn
  api_management_name = var.apim
  display_name        = var.display_name
  versioning_scheme   = var.versioning_scheme
}

resource "azurerm_api_management_api" "api" {
  for_each = var.versions

  name                = "${var.name}-${each.key}"
  resource_group_name = var.rn
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
