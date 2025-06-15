# ----------------VPC-----------------------
module "vpc" {
  source = "../../modules/vpc"

  # Module variables
  vpc_cidr = var.vpc_cidr
  region   = var.region
  subnets  = var.subnets 
}

# ----------------EC2------------------------
module "ec2" {
  source = "../../modules/ec2"

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
}