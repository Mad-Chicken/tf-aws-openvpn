module "sg_http_80" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git//modules/http-80?ref=tags/v4.0.0"

  name        = "sg_http_80"
  description = "Security group for http with ports 80 open"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = {
    Name = "http"
  }
}