module "create-sg" {
  source = "./modules/security-group"
}

module "create-vm" {
   source = "./modules/ec2-instance"
   ei_amiid = var.amiid
   ei_nameofvm = var.nameofvm
   ei_sgname = module.create-sg.sg_out_name
   ei_sizeofvm = var.sizeofvm
}

module "create-ebs" {
  source = "./modules/ebs-volume"
  ev_az = module.create-vm.ei_out_az
  ev_ec2id = module.create-vm.ei_out_id
}

data "aws_availability_zones" "all-azs" {

}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.4.0"
  name = "learn-vpc"
  cidr = "10.0.0.0/16"

  azs = data.aws_availability_zones.all-azs.names
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}