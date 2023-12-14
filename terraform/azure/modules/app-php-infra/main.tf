resource "azurerm_resource_group" "app_rg"{
    name = "${var.prefix}-resource-group"
    location = var.location
}

// Database
resource "azurerm_mysql_server" "app_mysql" {
  name                = "${var.prefix}-mysqlserver"
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name

  administrator_login          = var.login_db
  administrator_login_password = var.password_db

  sku_name   = "GP_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  public_network_access_enabled     = true

  ssl_enforcement_enabled = false
  ssl_minimal_tls_version_enforced  = "TLSEnforcementDisabled"
}

resource "azurerm_mysql_database" "app_db" {
  name                = var.name_db
  resource_group_name = azurerm_resource_group.app_rg.name
  server_name         = azurerm_mysql_server.app_mysql.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}


/*
Pour autoriser une fourchette d'ip a acceder a mon mysql
Pour autoriser tous le monde (0.0.0.0, 255.255.255.255)
Sinon dans les deux champs je ne met que mon ip
*/
resource "azurerm_mysql_firewall_rule" "app_fr" {
  name                = "${var.prefix}-allow-specific-ip"
  resource_group_name = azurerm_resource_group.app_rg.name
  server_name         = azurerm_mysql_server.app_mysql.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

// APP 1
resource "azurerm_app_service_plan" "app_sp" {
  name                = "${var.prefix}-service-plan"
  resource_group_name = azurerm_resource_group.app_rg.name
  location            = azurerm_resource_group.app_rg.location
  
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_as" {
  name                = "${var.prefix}-app-service"
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name
  app_service_plan_id = azurerm_app_service_plan.app_sp.id

  app_settings = {
    "DB_USER" = format("%s@%s", var.login_db, azurerm_mysql_server.app_mysql.name)
    "DB_PASSWORD" = var.password_db
    "DB_NAME" = var.name_db
    "DB_HOST" = azurerm_mysql_server.app_mysql.fqdn
  }
}