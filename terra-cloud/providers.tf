terraform {
  cloud {
   organization = "terraform-auged"
    workspaces {
      name = "test1"
    }
  }
}
provider "aws" {
  region = "ap-southeast-1"
  access_key = var.accesskey
  secret_key = var.secretkey
  }