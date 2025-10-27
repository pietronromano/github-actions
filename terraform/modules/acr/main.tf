/*
  Deploys an Azure Container Registry (ACR) 
  Steps:
    - Run this Terraform module first to deploy the ACR and obtain its ResourceId
    - Run a github workflow [NOT IMPLEMENTED YET
    ] or CLI commands to deploy an image to the ACR
    - Run the "aca" Terraform module to deploy the ACA, which can only reference an image in a pre-existing ACR repo (avoids error: MANIFEST_UNKNOWN)
*/


resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}



