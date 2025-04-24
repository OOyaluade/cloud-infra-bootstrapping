# Gets route tables for the specified VPC 
data "aws_route_tables" "route_tables_details" {
  vpc_id = aws_vpc.main.id
  filter {
    name   = "vpc-id"
    values = [aws_vpc.main.id]
  }
}
