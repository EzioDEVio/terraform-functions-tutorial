
resource "aws_vpc" "ci_cd_demo_vpc" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge({
    Name = "VPC-${var.environment}"
  }, local.common_tags)
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnet_cidrs[var.environment])
  vpc_id                  = aws_vpc.ci_cd_demo_vpc.id
  cidr_block              = var.public_subnet_cidrs[var.environment][count.index]
  map_public_ip_on_launch = true

  tags = merge({
    Name = "Public-Subnet-${count.index + 1}-${var.environment}"
  }, local.common_tags)
}


resource "aws_subnet" "private_subnet" {
  count                   = length(var.private_subnet_cidrs[var.environment])
  vpc_id                  = aws_vpc.ci_cd_demo_vpc.id
  cidr_block              = var.private_subnet_cidrs[var.environment][count.index]
  map_public_ip_on_launch = false

  tags = {
    Name        = "Private-Subnet-${count.index + 1}-${var.environment}"
    Terraform   = "true"
    Environment = var.environment
  }
}




resource "aws_internet_gateway" "ci_cd_demo_igw" {
  vpc_id = aws_vpc.ci_cd_demo_vpc.id

  tags = merge({
    Name = "IGW-${var.environment}"
  }, local.common_tags)
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.ci_cd_demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ci_cd_demo_igw.id
  }

  tags = merge({
    Name = "Public-Route-Table-${var.environment}"
  }, local.common_tags)
}

resource "aws_route_table_association" "public_route_table_association" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_eip" "nat" {
  vpc = true
}

#Public Subnet for NAT Gateway:
#Ensure you have a public subnet that can host the NAT Gateway.

#Create the NAT Gateway:
#This example assumes you have an Elastic IP (EIP) allocated for the NAT Gateway.


resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name        = "NAT-Gateway-${var.environment}"
    Terraform   = "true"
    Environment = var.environment
  }
}

#Configure Route Tables for Private Subnets:
#Route tables need to direct traffic from private subnets to the NAT gateway for internet access

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.ci_cd_demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name        = "Private-Route-Table-${var.environment}"
    Terraform   = "true"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  count          = length(aws_subnet.private_subnet)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

