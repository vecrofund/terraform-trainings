resource "aws_ebs_volume" "ev_createvolume" {
  availability_zone = var.ev_az
  size = "10"
}
resource "aws_volume_attachment" "ev_attach" {
  device_name = "/dev/sdf"
  instance_id = var.ev_ec2id
  volume_id = aws_ebs_volume.ev_createvolume.id
}