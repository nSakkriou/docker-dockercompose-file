variable available_subnets {
    type = list(string)
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

variable desired_instance {
    type = string
}

variable min_instance {
    type = string
}

variable max_instance {
    type = string
}

variable target_group_arn {
    type = string
}

variable ec2_security_group_id{
    type = string
}