output "out1" {
  value = aws_instance.vm-1.instance_type
}

output "vpc-id" {
  value = aws_vpc.test-vpc.id
}

output "ipofvm" {
  value = aws_instance.vm-1.public_ip
}

output "first-itemoflist1" {
  value = var.list1[0]
}
output "first-itemofset1" {
  value = tolist(var.set1)[0]
}