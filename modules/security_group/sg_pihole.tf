module "sg_pihole" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git?ref=tags/v3.2.0"

  name        = "sg_pihole"
  description = "Pihole security group"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_with_cidr_blocks = [
    {
      cidr_block  = "0.0.0.0/0"
      from_port   = 67
      to_port     = 67
      protocol    = "tcp"
      description = "ingress 67 tcp"
    },
    {
      cidr_block  = "0.0.0.0/0"
      from_port   = 53
      to_port     = 53
      protocol    = "tcp"
      description = "ingress 53 tcp"
    },
    {
      cidr_block  = "0.0.0.0/0"
      from_port   = 53
      to_port     = 53
      protocol    = "udp"
      description = "ingress 53 udp"
    }
  ]
  egress_with_cidr_blocks = [
    {
      cidr_block  = "0.0.0.0/0"
      protocol    = "tcp"
      from_port   = 67
      to_port     = 67
      description = "egress 67 tcp"
    },
    {
      cidr_block  = "0.0.0.0/0"
      protocol    = "tcp"
      from_port   = 53
      to_port     = 53
      description = "egress 53 tcp"
    },
    {
      cidr_block  = "0.0.0.0/0"
      protocol    = "udp"
      from_port   = 53
      to_port     = 53
      description = "egress 53 udp"
    }
  ]

  tags = {
    Name = "pihole"
  }
}