variable "subscription_id" {
  type        = string
  description = "Subscription ID in Azure"
}
variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
  default = "rg-aca"
}

variable "location" {
  type        = string
  description = "Resources location in Azure"
  default = "northeurope"
}

variable "acr_name" {
  type        = string
  description = "ACR name"
  default = "prnacracatest"
}
