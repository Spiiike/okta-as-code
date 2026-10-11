terraform {
  required_version = "~> 1.7"

  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 7.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "sttfstate800573"
    container_name       = "tfstate"
    key                  = "okta/terraform.tfstate"
    use_azuread_auth     = true
  }
}

provider "okta" {}

data "okta_group" "everyone" {
  name = "Everyone"
}

# The quick brown fox jumps over the lazy dog.