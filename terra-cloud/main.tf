resource "aws_instance" "instance" {
  ami           = "ami-02453f5468b897e31"
  instance_type = "t2.micro"
}
