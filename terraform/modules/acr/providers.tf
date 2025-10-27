terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 4.49.0" # latest as of 23-October-2025
    }
  }
}

provider "azurerm" {
  # Required when running locally
  subscription_id = var.subscription_id
  # Configuration options
  features {}
}