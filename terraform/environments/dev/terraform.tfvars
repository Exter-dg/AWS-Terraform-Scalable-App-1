#-------------------Common Variables---------------
region = "us-east-1"

#-------------------VPC Variables------------------
vpc_cidr = "10.0.248.0/21"

subnets = {
    "public_subnet1" = {
        name = "public_subnet1"
        cidr_block = "10.0.252.0/24"
        availability_zone = "us-east-1a"
        is_public = true
    }
    "public_subnet2" = {
        name = "public_subnet2"
        cidr_block = "10.0.253.0/24"
        availability_zone = "us-east-1b"
        is_public = true
    }
    "private_subnet1" = {
        name = "private_subnet1"
        cidr_block = "10.0.254.0/24"
        availability_zone = "us-east-1a"
        is_public = false
    }
    "private_subnet2" = {
        name = "private_subnet2"
        cidr_block = "10.0.255.0/24"
        availability_zone = "us-east-1b"
        is_public = false
    }
}