variable instance_configs {
    type = list(object({
        subnet_id = string,
        name = string
        security_group = string
    }))
}

variable host_env {
    type = string
}

variable dbname_env {
    type = string
}

variable user_env {
    type = string
}

variable password_env {
    type = string
}