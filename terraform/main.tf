provider "azurerm"{
    features {}
    
    subscription_id = var.VAR_SUBSCRIPTION_ID
    tenant_id = var.VAR_TENANT_ID
    client_id = var.VAR_CLIENT_ID
    client_secret = var.VAR_CLIENT_SECRET

    skip_provider_registration = true
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example"{
    name = "toto"
    location = "West Europe"
}