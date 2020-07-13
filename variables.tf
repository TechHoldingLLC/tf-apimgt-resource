variable "name" {}
variable "rg" {
  type = string
}
variable "apim" {
  type = string
}
variable "versioning_scheme" {
  default = "Segment"
  type    = string
}
variable "revision" {
  default = "1"
  type    = string
}
variable "display_name" {
  type = string
}
variable "subscription_required" {
  type    = bool
  default = false
}

variable "policy" {}

variable "versions" {
  type = map(object({
    path = string
    subscription_key_parameter_names = object({
      header = string
      query  = string
    })
    policy = object({})
    routes = list(object({
      operation_id = string
      display_name = string
      method       = string
      policy       = object({})
      src          = string
    }))
    products = list(string)
  }))
}