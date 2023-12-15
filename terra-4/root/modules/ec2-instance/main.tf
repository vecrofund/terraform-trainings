resource "aws_instance" "ei-createvm" {
  ami = var.ei_amiid
  instance_type = var.ei_sizeofvm
  tags = {
    Name = var.ei_nameofvm
  }
  security_groups = [var.ei_sgname]
}