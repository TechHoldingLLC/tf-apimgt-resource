output "apis" {
  value = azurerm_api_management_api.api
}

output "routes" {
  value = local.routes
}

output "products" {
  value = local.products
}

output "versions_policy" {
  value = local.versions_policy
}

output "routes_policy" {
  value = local.routes_policy
}
