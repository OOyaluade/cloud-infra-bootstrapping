output "subnet_id_list" {
  value = local.cidr_block
}

output "public_subnet" {
  value = aws_subnet.public_subnet

}


output "private_subnet" {
  value = aws_subnet.private_subnet

}


output "route_tables_details" {
  value = data.aws_route_tables.route_tables_details

}



