## How to use the module
```hcl
module "my_api" {
  source = "github.com/TechHoldingLLC/tf-apimgt-resource?ref=v1.1.0"

  name = "${var.prefix}-${var.env}-helloworld"
  rg = var.resource_group_name
  apim = var.api_mgt_name
  display_name = var.apis.helloworld.display_name
  versioning_scheme = var.apis.helloworld.versioning_scheme

  versions = var.apis.helloworld.versions
}
```

## Variable used for the module
```hcl
apis = {
  helloworld = {
    display_name = "Hello World"
    versioning_scheme = "Segment"
    versions = {
      v1 = {
        path = "hello"
        subscription_key_parameter_names = {
          header = "Api-Key"
          query  = "key"
        }
        routes = [
          {
            operation_id = "get-hello"
            display_name = "GET Hello"
            method = "GET"
            dst = "http://my.backend.net/hello/v1"
            src = "/"
          }
        ]
        products = ["unlimited"]
      }
      v2 = {
        path = "hello"
        subscription_key_parameter_names = {
          header = "Api-Key"
          query  = "key"
        }
        routes = [
          {
            operation_id = "get-hello"
            display_name = "GET Hello"
            method = "GET"
            dst = "http://my.backend.net/hello/v2"
            src = "/"
          },
          {
            operation_id = "post-hello"
            display_name = "POST Hello"
            method = "POST"
            dst = "http://my.backend.net/hello/v2"
            src = "/"
          }
        ]
        products = ["unlimited"]
      }
    }
  }
}
```
