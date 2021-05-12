module "sg_https_443" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git//modules/https-443?ref=tags/v4.0.0"

  name        = "sg_https_443"
  description = "Security group for http with ports 80 open"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = {
    Name = "https"
  }
}