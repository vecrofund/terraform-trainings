resource "aws_instance" "vm-1" {
  ami           = "ami-02453f5468b897e31"
  instance_type = "t3.micro"
  tags = {
    Name = "vm-1"
  }
}