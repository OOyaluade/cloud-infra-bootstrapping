output "name" {
  
  value =    slice([for cidr_block in range(8) :  cidrsubnet("172.16.0.0/16",3,cidr_block)], 4, 8)
}