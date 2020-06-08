variable "name" {}
variable "resource_group" {
  default = {
    name = ""
  }
  type = object({
    name = string
  })
}
variable "apimgt" {
  default = {
    name = ""
  }
  type = object({
    name = string
  })
}
variable "revision" {
  default = "1"
  type    = string
}
variable "display_name" {}
variable "path" {}
variable "subscription_key_parameters" {
  default = {
    header = "API-Key"
    query  = "key"
  }
  type = object({
    header = string
    query  = string
  })
}
variable "method_id" {}
variable "method_name" {}
variable "method" {
  default = "GET"
  type    = string
}
variable "url" {
  default = "/*"
  type    = string
}
variable "backend" {
  default = {
    url = ""
  }
  type = object({
    url = string
  })
}
variable "products" {
  default = []
  type    = list(string)
}