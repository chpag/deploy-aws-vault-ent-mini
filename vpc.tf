module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version  = "3.0.0"

  name = "${var.prefix}-vault-vpc"
  cidr = var.vpc_cidr

  azs             = [var.az]
  private_subnets = [var.private_subnet_cidr]
  public_subnets  = [var.public_subnet_cidr]

  enable_nat_gateway = true
  enable_vpn_gateway = true

}

