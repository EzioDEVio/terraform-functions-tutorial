
resource "aws_vpc" "ci_cd_demo _vpc" {
  cidr_block = var.cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = merge({
    Name = "VPC-${var.environment}"
  }, local.common_tags)
}

resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.ci_cd_demo_vpc.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true

  tags = merge({
    Name = "Public-Subnet-${count.index + 1}-${var.environment}"
  }, local.common_tags)
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
