variable instance_configs {
    type = list(object({
        subnet_id = string,
        name = string
        security_group = string
    }))
}