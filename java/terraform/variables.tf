variable "resource_group" {
  description = "The resource group"
  default = "rg-terraform"
}

variable "application_name" {
  description = "The Spring Boot application name"
  default     = "pnrterraformapp"
}

variable "location" {
  description = "The Azure location where all resources in this example should be created"
  default     = "westeurope"
}
