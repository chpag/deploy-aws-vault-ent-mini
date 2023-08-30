module "vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  name                   = "${var.prefix}-vault"
  cidr                   = var.vpc_cidr
  azs                    = var.azs
  enable_nat_gateway     = true
  one_nat_gateway_per_az = true
  private_subnets        = var.private_subnet_cidrs
  public_subnets         = var.public_subnet_cidrs

  tags = var.vpc_tags
}
