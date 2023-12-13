output "app_url" {
    value = azurerm_app_service.app_as.default_site_hostname
}