
variable "albname" {
  type = string
  default = "dajmox-xk"
}
variable "loadbalancer_security_group" {}
variable "vpc_id" {}
variable "LT-SG" {}
variable "region" {
  type = string
  default = "us-east-1"
}
variable "subnet1" {}
variable "subnet2" {}