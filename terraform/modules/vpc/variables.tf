variable region {
    type = string
}

variable vpc_cidr {
    type = string
}

variable subnets {
    type = map(object({
        name: string
        cidr_block: string
        availability_zone: string
        is_public: bool
    }))
}