resource "aws_instance" "terra-ac2" {
  count = length(var.az-list)
  ami = var.ami
  instance_type = var.inst-type
  availability_zone = "${var.region}${var.az-list[count.index]}"
  security_groups = [aws_security_group.terra-sg.name]
  tags = {
    Name = "machine-${count.index}"
  }
}

resource "aws_ebs_volume" "terra-ebs" {
  count = length(var.az-list)
  availability_zone = "ap-southeast-1${var.az-list[count.index]}"
  size = 10

  tags = {
    Name = "ebs-${count.index}"
  }
}

resource "aws_volume_attachment" "terra_attach" {
  count = length(var.az-list)
  device_name = "/dev/sdf"
  instance_id = aws_instance.terra-ac2[count.index].id
  volume_id   = aws_ebs_volume.terra-ebs[count.index].id
}

resource "aws_security_group" "terra-sg" {
  name = "terra-sg"
  ingress {
    description = "web from VPC"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
  }
}

data "aws_availability_zones" "all-azs" {

}
resource "aws_instance" "machines" {
  count = length(data.aws_availability_zones.all-azs.names)
  ami = var.amiid
  instance_type = var.instance-type
  availability_zone = data.aws_availability_zones.all-azs.names[count.index]
  tags = {
    Name = "machine-${count.index+1}"
  }
  security_groups = [aws_security_group.my-sg-new.name]
  user_data =<<EOF
#!/bin/bash
yum update -y
yum install -y httpd
service httpd start
chkconfig httpd on
echo "<body bgcolor="#FFFF00"></body>" > /var/www/html/index.html
EOF
}
resource "aws_security_group" "my-sg-new" {

  ingress {
    description = "TLS from VPC"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks= ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "terra-sg-new"
  }
}
output "ip-of-firstvm" {
  value = aws_instance.machines[0].public_ip
}

resource "aws_elb" "yellow" {
  name               = "yellow-elb"
  availability_zones = data.aws_availability_zones.all-azs.names
  security_groups = [aws_security_group.terra-sg.name]


  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   =  aws_instance.terra-ac2.*.id
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "yellow-elb"
  }
}