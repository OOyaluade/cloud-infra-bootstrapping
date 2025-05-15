variable "CareMesh_Developers_Account_Name" {
  type    = string
  default = "CareMesh_Developers"
}

variable "CareMesh_Developers_Account_Email" {
  type    = string
  default = "oyaluadedamilola+c_dev@damilstudio.com"
  validation {
    condition     = can(regex("[a-zA-Z._%+-]+@[a-zA-Z._%+-]+\\.[a-zA-Z]{2,}", var.CareMesh_Developers_Account_Email))
    error_message = "Not a valid email address"
  }

}


variable "CareMesh_Production_Account_Name" {
  type    = string
  default = "CareMesh_Production"
}

variable "CareMesh_Production_Account_Email" {
  type    = string
  default = "oyaluadedamilola+c_prod@damilstudio.com"
  validation {
    condition     = can(regex("[a-zA-Z._%+-]+@[a-zA-Z._%+-]+\\.[a-zA-Z]{2,}",var.CareMesh_Production_Account_Email))
    error_message = "Not a valid email address"
  }

}


variable "CareMesh_Machine_Learning_Account_Name" {
  type    = string
  default = "CareMesh_Machine_Learning_Engineer"
}

variable "CareMesh_Machine_Learning_Account_Email" {
  type    = string
  default = "oyaluadedamilola+c_mle@damilstudio.com"
  validation {
    condition     = can(regex("[a-zA-Z._%+-]+@[a-zA-Z._%+-]+\\.[a-zA-Z]{2,}",var.CareMesh_Machine_Learning_Account_Email))
    error_message = "Not a valid email address"
  }

} 
