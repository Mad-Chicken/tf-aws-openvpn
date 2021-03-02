module "ec2_cluster" {
  source                 = "git::https://github.com/terraform-aws-modules/terraform-aws-ec2-instance.git?ref=tags/v2.10.0"
  name                   = var.name
  instance_count         = var.instance_count
  ami                    = var.ami
  instance_type          = var.ec2_size
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids
  subnet_id              = var.subnet_id
  private_ip             = var.private_ip
  user_data              = var.user_data

  tags = {
    Description = var.tags[0]
    Environment = var.tags[1]
    Terraform   = "true"
  }
}