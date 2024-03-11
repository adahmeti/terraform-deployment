variable "access_key" {
  type    = string
  default = "" 
}
variable "secret_key" {
  type    = string
  default = ""
}
variable "region" {
  type    = string
  default = "ca-central-1"
}

variable "environment" {
  type    = string
  default = "Dev"
}

variable "s3-bucket" {
  type    = string
  default = "ecommercepolymathlabzsz"
}
