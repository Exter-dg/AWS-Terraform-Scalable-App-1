output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
    description = "List of public Subnet IDs"

    value = [
        for key, value in aws_subnet.subnets :
        value.id if var.subnets[key].is_public == true
    ]
}

output "private_subnet_ids" {
    description = "List of private Subnet IDs"

    value = [
        for key, value in aws_subnet.subnets :
        value.id if var.subnets[key].is_public == false
    ]
}
