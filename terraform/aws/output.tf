output "loadbalancer_host"{
    value = module.loadbalancer_autoscaling.loadbalancer_url
}