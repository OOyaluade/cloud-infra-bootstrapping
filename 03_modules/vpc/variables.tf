variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string

}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  
}

variable "azs_public" {
  description = "List of public availability zones"
  type        = list(string)
}

variable "azs_private" {
  description = "List of availability zones"
  type        = list(string)
}


variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
