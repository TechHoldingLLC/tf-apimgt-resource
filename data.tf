locals {
  routes = flatten([for kv, v in var.versions :
    [for r in v.routes : {
      version      = kv
      operation_id = r.operation_id
      display_name = r.display_name
      method       = r.method
      dst          = r.dst
      src          = r.src
    }]
  ])
  products = flatten([for kv, v in var.versions :
    [for p in v.products : {
      version = kv
      product = p
    }]
  ])
}
