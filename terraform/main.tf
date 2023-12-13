provider "azurerm"{
    features {}
    
    subscription_id = var.VAR_SUBSCRIPTION_ID
    tenant_id = var.VAR_TENANT_ID
    client_id = var.VAR_CLIENT_ID
    client_secret = var.VAR_CLIENT_SECRET

    skip_provider_registration = true
}

module "app_php_infra" {
    for_each = { for params in var.MODULES_PARAMS : params.prefix => params }
    
    source = "./modules/app-php-infra"
    
    location = each.value.location
    prefix = each.value.prefix

    login_db = var.VAR_APP_DB_LOGIN
    password_db = var.VAR_APP_DB_PASSWORD
    name_db = var.VAR_APP_DB_NAME   
}


resource "azurerm_resource_group" "app_rg"{
    name = "global-resource-group"
    location = "North Europe"
}


resource "azurerm_frontdoor" "global_fd" {
  name                = "global-FrontDoor"
  resource_group_name = azurerm_resource_group.app_rg.name

  routing_rule {
    name               = "exampleRoutingRule1"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["global-frontdoor"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "global-backend"
    }
  }

  backend_pool_load_balancing {
    name = "exampleLoadBalancingSettings1"
  }

  backend_pool_health_probe {
    name = "exampleHealthProbeSetting1"
  }

  backend_pool {
    name = "global-backend"
    backend {
        
      host_header = module.app_php_infra["app1"].app_url
      address     = module.app_php_infra["app1"].app_url
      http_port   = 80
      https_port  = 443
    }

    backend {
      host_header = module.app_php_infra["app2"].app_url
      address     = module.app_php_infra["app2"].app_url
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "exampleLoadBalancingSettings1"
    health_probe_name   = "exampleHealthProbeSetting1"
  }

  frontend_endpoint {
    name      = "global-frontdoor"
    host_name = "global-frontdoor.azurefd.net"
  }
}