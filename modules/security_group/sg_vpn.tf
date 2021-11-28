module "sg_vpn" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git?ref=tags/v4.0.0"

  name        = "sg_vpn"
  description = "VPN security group"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_with_cidr_blocks = [
    {
      cidr_block  = "0.0.0.0/0"
      from_port   = 943
      to_port     = 943
      protocol    = "tcp"
      description = "ingress 943 tcp"
    },
    {
      cidr_block  = "0.0.0.0/0"
      from_port   = 1194
      to_port     = 1194
      protocol    = "tcp"
      description = "ingress 1194 tcp"
    },
    {
      cidr_block  = "0.0.0.0/0"
      from_port   = 1194
      to_port     = 1194
      protocol    = "udp"
      description = "ingress 1194 udp"
    }
  ]
  egress_with_cidr_blocks = [
    {
      cidr_block  = "0.0.0.0/0"
      protocol    = "tcp"
      from_port   = 943
      to_port     = 943
      description = "egress 943 tcp"
    },
    {
      cidr_block  = "0.0.0.0/0"
      protocol    = "tcp"
      from_port   = 1194
      to_port     = 1194
      description = "egress 1194 tcp"
    },
    {
      cidr_block  = "0.0.0.0/0"
      protocol    = "udp"
      from_port   = 1194
      to_port     = 1194
      description = "egress 1194 udp"
    }
  ]

  tags = {
    Name = "vpn"
  }
}