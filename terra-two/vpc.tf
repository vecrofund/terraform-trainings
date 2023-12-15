resource "aws_vpc" "test-vpc" {
  cidr_block = var.vpc-cidr
  tags = {
    Name = var.vpc-name
}
}
resource "aws_internet_gateway" "test-vpc-ig" {
  vpc_id = aws_vpc.test-vpc.id
  tags = {
 Name = var.ig-name
  }
}
resource "aws_subnet" "testvpc-sub" {
  count =  length(var.sub-cidrs)
  vpc_id = aws_vpc.test-vpc.id
  cidr_block = var.sub-cidrs[count.index]
  tags = {
    Name = "${var.vpc-name}-subnet-${count.index+1}"
  }
}

#resource "aws_subnet" "testvpc-sub-1" {
#  vpc_id = aws_vpc.test-vpc.id
#  cidr_block = var.sub-cidrs[0]
# tags = {
#   Name = "testvpc-sub-1"
#}
#}
#resource "aws_subnet" "testvpc-sub-2" {
#  vpc_id = aws_vpc.test-vpc.id
#  cidr_block = var.sub-cidrs[1]
#tags = {
#  Name = "testvpc-sub-2"
#}
#}
resource "aws_default_route_table" "testvpc-def-rt" {
  default_route_table_id = aws_vpc.test-vpc.default_route_table_id
   tags = {
     Name = "testvpc-def-rt"
}
route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.test-vpc-ig.id
}
}
resource "aws_route_table" "testvpc-pvt-rt" {
vpc_id = aws_vpc.test-vpc.id
tags = {
   Name = "testvpc-pvt-rt"
}
}
resource "aws_route_table_association" "sub2-pvt-rt" {
 route_table_id = aws_route_table.testvpc-pvt-rt.id
 subnet_id = aws_subnet.testvpc-sub[1].id
}


