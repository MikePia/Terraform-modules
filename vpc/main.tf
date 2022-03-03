provider "aws" {
  region                   = "us-west-2"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
}
# Query all avilable Availibility Zone
data "aws_availability_zones" "available" {}
# VPC Creation
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "my-new-test-terraform-vpc"
  }
}

# Creating Internet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my-test-igw"
  }
}
# Public Route Table
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "my-test-public-route"
  }
}
# Private Route Table
resource "aws_default_route_table" "private_route" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  tags = {
    Name = "my-private-route-table"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  count                   = 2
  cidr_block              = var.public_cidrs[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "my-test-public-subnet.${count.index + 1}"
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  count             = 2
  cidr_block        = var.private_cidrs[count.index]
  vpc_id            = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "my-test-private-subnet.${count.index + 1}"
  }
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_subnet_assoc" {
  count          = 2
  route_table_id = aws_route_table.public_route.id
  subnet_id      = aws_subnet.public_subnet.*.id[count.index]
  depends_on     = [aws_route_table.public_route, aws_subnet.public_subnet]
}

# Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private_subnet_assoc" {
  count          = 2
  route_table_id = aws_default_route_table.private_route.id
  subnet_id      = aws_subnet.private_subnet.*.id[count.index]
  depends_on     = [aws_default_route_table.private_route, aws_subnet.private_subnet]
}

# Security Group Creation
resource "aws_security_group" "test_sg" {
  name   = "my-test-sg"
  vpc_id = aws_vpc.main.id
}

# Ingress Security Port 22
resource "aws_security_group_rule" "ssh_inbound_access" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.test_sg.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "http_inbound_access" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.test_sg.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

# All OutBound Access
resource "aws_security_group_rule" "all_outbound_access" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.test_sg.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

# resource "aws_eip" "my-test-eip" {
#   vpc = true
# }

# resource "aws_nat_gateway" "my-test-nat-gateway" {
#   allocation_id = aws_eip.my-test-eip.id
#   subnet_id     = aws_subnet.public_subnet.0.id
# }

# # Adding Route for Transit Gateway

# resource "aws_route" "my-tgw-route" {
#   route_table_id         = aws_route_table.public_route.id
#   destination_cidr_block = "0.0.0.0/0"
#   transit_gateway_id     = var.transit_gateway
# }


/*
Day 2 VPC
https://www.youtube.com/watch?v=rQ4_YYm3M7w&t=722s
Dev-->Test-->Prod
    VPC Peering/Transit Gateway
VPC --> VPC2
Network Isolation

10.0.0.0.0/16
Public Subnet 
Private Subnet 10.0.3.0/24 10.0.4.0/24

US West (Oregon) - us-west-2
us-west-2a: 10.0.1.0/24 10.0.3.0/24
us-west-2b: 10.0.2.0/24 10.0.4.0/24
us-west-2c (usw2-az3) Enabled by default unused
us-west-2d (usw2-az4) Enabled by default unused

VPC
Route Table
Network ACL
Security Group
-------------------------
Subnet
Custom Route Table
Internet Gateway
*/
