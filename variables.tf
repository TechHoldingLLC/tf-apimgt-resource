variable "name" {}
variable "resource_group" {
  default = {
    name = ""
  }
}
variable "apimgt" {
  default = {
    name = ""
  }
}
variable "revision" {
  default = "1"
}
variable "display_name" {}
variable "path" {}
variable "subscription_key_parameters" {
  default = {
    header = "API-Key"
    query  = "key"
  }
}
variable "method_id" {}
variable "method_name" {}
variable "method" {
  default = "GET"
}
variable "url" {
  default = "/*"
}
variable "backend" {
  default = {
    url = ""
  }
}