variable VAR_CLIENT_SECRET {}
variable VAR_SUBSCRIPTION_ID {}
variable VAR_CLIENT_ID {}
variable VAR_TENANT_ID {}

variable VAR_APP1_DB_LOGIN {}
variable VAR_APP1_DB_PASSWORD {}

variable VAR_APP1_DB_NAME {
    type = string
    default = "app1-db"
}

variable VAR_APP_DB_LOGIN {}
variable VAR_APP_DB_PASSWORD {}

variable VAR_APP_DB_NAME {
    type = string
    default = "app1-db"
}


variable MODULES_PARAMS {
  default = [
    {
        prefix = "app1"
        location = "North Europe"
    },
    {
        prefix = "app2"
        location = "West Europe"
    },
  ]
}