resource "aws_instance" "vm-3" {
  ami               = "ami-02453f5468b897e31"
  instance_type     = "t3.micro"
  availability_zone = "ap-southeast-1b"
  tags              = {
    Name = "vm-exercise-1"
  }
}

resource "aws_ebs_volume" "ebs-3" {
  availability_zone = aws_instance.vm-3.availability_zone
  size = "20"
}

resource "aws_volume_attachment" "vol-attach3" {
  device_name = "/dev/sdf"
  instance_id       = aws_instance.vm-3.id
  volume_id         = aws_ebs_volume.ebs-3.id
}

resource "aws_security_group" "my-sg" {

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "terra-sg"
  }
}