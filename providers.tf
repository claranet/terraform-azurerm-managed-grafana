terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.92"
    }
    azurecaf = {
      source  = "claranet/azurecaf"
      version = "~> 1.2, >= 1.2.22"
    }
  }
}
