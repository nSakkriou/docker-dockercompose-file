output "app_url" {
    value = {
        host = azurerm_app_service.app_as.default_site_hostname
    }
}
