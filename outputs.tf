output "apis" {
  value = azurerm_api_management_api.api
}

output "routes" {
  value = local.routes
}

output "products" {
  value = local.products
}
