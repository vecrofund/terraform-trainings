variable "typenumber" {
  type = number
  default = 9
}
variable "boolvar" {
  #only take up true false
  type = bool
  default = true
}

variable "vpc-name" {
  type = string
  default = "testvpc"
}
variable "vpc-cidr" {
  type = string
  default = "10.0.0.0/16"
}
variable "ig-name" {
  default = "testvpc-ig"
}
variable "list1" {
  type = list(string)
  default = ["a","b","b","c"]
}
variable "set1" {
  type = set(string)
  default = ["a","b","c"]
}

variable "sub-cidrs" {
  default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}