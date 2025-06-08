# ----------------VPC-----------------------
module "vpc" {
  source = "../../modules/vpc"

  # Module variables
  vpc_cidr = var.vpc_cidr
  region   = var.region
  subnets  = var.subnets 
}
