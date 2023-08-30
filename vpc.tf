
module "vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  name                   = "${var.prefix}-vault"
  cidr                   = var.vpc_cidr
  azs                    = [ var.az ]
  enable_nat_gateway     = true
  one_nat_gateway_per_az = true
  private_subnets        = [ var.private_subnet_cidr ]
  public_subnets         = [ var.public_subnet_cidr ]

  tags = var.tags
}
