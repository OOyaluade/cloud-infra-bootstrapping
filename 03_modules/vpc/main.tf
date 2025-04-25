resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = merge({
    Name = "caremesh-vpc"
  }, var.tags)
}

resource "aws_subnet" "public" {
  for_each = toset(var.public_subnets)

  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
  availability_zone = element(var.azs_public, index(var.public_subnets, each.value))
  map_public_ip_on_launch = true

  tags = merge({
    Name = "public-${each.value}"
  }, var.tags)
}

resource "aws_subnet" "private" {
  for_each = toset(var.private_subnets)

  vpc_id     = aws_vpc.main.id
  cidr_block = each.value
  availability_zone = element(var.azs_private, index(var.private_subnets, each.value))

  tags = merge({
    Name = "private-${each.value}"
  }, var.tags)
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge({
    Name = "caremesh-igw"
  }, var.tags)
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge({
    Name = "public-rt"
  }, var.tags)
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}


