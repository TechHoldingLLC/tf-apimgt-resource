locals {
  list_routes = flatten([for kv, v in var.versions :
    [for r in v.routes : {
      version      = kv
      operation_id = r.operation_id
      display_name = r.display_name
      method       = r.method
      policy       = lookup(r, "policy", false) ? r.policy : null
      src          = r.src
    }]
  ])
  list_products = flatten([for kv, v in var.versions :
    [for p in v.products : {
      version = kv
      product = p
    }]
  ])
  versions_policy = {
    for k, v in var.versions : "${k}" => v.policy if lookup(v, "policy", false)
  }
  routes = {
    for r in local.list_routes : "${r.version}-${r.operation_id}" => r
  }
  routes_policy = {
    for r in local.list_routes: "${r.version}-${r.operation_id}" => r if lookup(r.version, "policy", false)
  }
  products = {
    for p in local.list_products : "${p.version}-${p.product}" => p
  }
}
