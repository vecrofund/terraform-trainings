resource "aws_instance" "vm-2" {
  ami           = "ami-02453f5468b897e31"
  instance_type = "t3.micro"
  availability_zone = "ap-southeast-1b"
  tags = {
    Name = "vm-exercise-1"
  }
}

resource "aws_ebs_volume" "ebs-1" {
  availability_zone = aws_instance.vm-2.availability_zone
  size = "20"
}

resource "aws_volume_attachment" "vol-attach" {
  device_name = "/dev/sdf"
  instance_id       = aws_instance.vm-2.id
  volume_id         = aws_ebs_volume.ebs-1.id
}
