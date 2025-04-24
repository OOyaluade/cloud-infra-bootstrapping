# VPC for both the private and public subnets
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = {
    Name = "CareMesh"
  }
}

# public subnets
resource "aws_subnet" "public_subnet" {
  for_each                = tomap(local.public_regon_subnet)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.key
  availability_zone       = "us-east-1${each.value}"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public_CareMesh-east-1-${each.value}"
  }
}

# private subnets
resource "aws_subnet" "private_subnet" {
  for_each          = tomap(local.private_regon_subnet)
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.key
  availability_zone = "us-east-1${each.value}"

  tags = {
    Name = "Private_CareMesh-east-1-${each.value}"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
    Environment = "production"
  }
}


resource "aws_route_table_association" "public_association" {
  for_each       = aws_subnet.public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_default_route.id
}

resource "aws_route_table" "public_default_route" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "public_default_route"
    Environment = "production"
    Project     = "CareMesh"
    Description = "Route table for public subnets"
  }
}



# default route for public access 
resource "aws_route" "public_route_default" {
  depends_on             = [aws_route_table.public_default_route]
  route_table_id         = aws_route_table.public_default_route.id
  gateway_id             = aws_internet_gateway.gw.id
  destination_cidr_block = "0.0.0.0/0"


}






