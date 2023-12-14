output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "subnet-az1-public_id" {
    value = aws_subnet.subnet_az1_public.id
}

output "subnet-az2-public_id" {
    value = aws_subnet.subnet_az2_public.id
}

output "subnet-az1-private_id" {
    value = aws_subnet.subnet_az2_private.id
}

output "subnet-az2-private_id" {
    value = aws_subnet.subnet_az2_private.id
}