provider "aws" {
  region = "us-east-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc_infra" {
  source = "./modules/vpc_infra"
  vpc_name = "vpc-app-php"
  availability_zone = "us-east-2"
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc_infra.vpc_id
}

module "ec2"{
  source = "./modules/ec2_replica"
  instance_configs = [
    {
      subnet_id = module.vpc_infra.subnet-az1-private_id,
      name = "EC2_az1"
      security_group = module.security_groups.ec2_security_group_id
    },
    {
      subnet_id = module.vpc_infra.subnet-az2-private_id,
      name = "EC2_az2"
      security_group = module.security_groups.ec2_security_group_id
    }
  ]
}

module "loadbalancer" {
  source = "./modules/alb"
  vpc_id = module.vpc_infra.vpc_id
  subnet_id_list = [module.vpc_infra.subnet-az1-public_id,  module.vpc_infra.subnet-az2-public_id]
  loadbalancer_security_group_id = module.security_groups.loadbalancer_security_group_id
  instances_id = module.ec2.instance_id
}