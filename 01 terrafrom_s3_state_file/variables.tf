variable "bucket_name" {
  
  description = "The name of the S3 bucket"
  type        = string  
  default     = "caremesh-tf-2723" 
  sensitive   = false  

}

variable "environment" {
  
  description = "The environment for the deployment"
  type        = string
  default     = "development"
  sensitive   = false
}


variable "lock_table_name" {
  
  description = "The name of the DynamoDB lock table"
  type        = string
  default     = "terraform_lock_table"
  sensitive   = false
}