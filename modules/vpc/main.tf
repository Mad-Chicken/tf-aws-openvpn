
module "vpc" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=tags/v2.60.0"

  name = var.vpc_name
  cidr = var.cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnet
  public_subnets  = var.vpc_public_subnet

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}