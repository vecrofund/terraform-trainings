
variable "az-list" {
  type = list (string)
  default = ["a","b","c"]
}

variable "ami" {
  type = string
  default = "ami-02453f5468b897e31"
}

variable "inst-type"{
  default = "t3.micro"
}

variable "region" {
  type = string
  default = "ap-southeast-1"
}

variable "region-name" {
  type = string
}
variable "amiid" {

}
variable "instance-type" {
}