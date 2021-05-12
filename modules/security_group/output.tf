### Egress ###
output "sg_egress_id" {
  description = "The ID of sg_egress"
  value       = module.sg_egress.security_group_id
}

output "sg_egress_group_vpc_id" {
  description = "The VPC ID"
  value       = module.sg_egress.security_group_vpc_id
}

output "sg_egress_group_owner_id" {
  description = "The owner ID"
  value       = module.sg_egress.security_group_owner_id
}

output "sg_egress_group_name" {
  description = "The name of the security group"
  value       = module.sg_egress.security_group_name
}

output "sg_egress_group_description" {
  description = "The description of the security group"
  value       = module.sg_egress.security_group_description
}


### HTTP ###
output "sg_http_80_id" {
  description = "The ID of sg_http_80"
  value       = module.sg_http_80.security_group_id
}

output "sg_http_80_group_vpc_id" {
  description = "The VPC ID"
  value       = module.sg_http_80.security_group_vpc_id
}

output "sg_http_80_group_owner_id" {
  description = "The owner ID"
  value       = module.sg_http_80.security_group_owner_id
}

output "sg_http_80_group_name" {
  description = "The name of the security group"
  value       = module.sg_http_80.security_group_name
}

output "sg_http_80_group_description" {
  description = "The description of the security group"
  value       = module.sg_http_80.security_group_description
}


### HTTPS ###
output "sg_https_443_id" {
  description = "The ID of sg_https_443"
  value       = module.sg_https_443.security_group_id
}

output "sg_https_443_group_vpc_id" {
  description = "The VPC ID"
  value       = module.sg_https_443.security_group_vpc_id
}

output "sg_https_443_group_owner_id" {
  description = "The owner ID"
  value       = module.sg_https_443.security_group_owner_id
}

output "sg_https_443_group_name" {
  description = "The name of the security group"
  value       = module.sg_https_443.security_group_name
}

output "sg_https_443_group_description" {
  description = "The description of the security group"
  value       = module.sg_https_443.security_group_description
}


### PIHOLE ###
output "sg_pihole_id" {
  description = "The ID of sg_pihole"
  value       = module.sg_pihole.security_group_id
}

output "sg_pihole_group_vpc_id" {
  description = "The VPC ID"
  value       = module.sg_pihole.security_group_vpc_id
}

output "sg_pihole_group_owner_id" {
  description = "The owner ID"
  value       = module.sg_pihole.security_group_owner_id
}

output "sg_pihole_group_name" {
  description = "The name of the security group"
  value       = module.sg_pihole.security_group_name
}

output "sg_pihole_group_description" {
  description = "The description of the security group"
  value       = module.sg_pihole.security_group_description
}


### SSH ###
output "sg_ssh_22_id" {
  description = "The ID of sg_ssh_22"
  value       = module.sg_ssh_22.security_group_id
}

output "sg_ssh_22_group_vpc_id" {
  description = "The VPC ID"
  value       = module.sg_ssh_22.security_group_vpc_id
}

output "sg_ssh_22_group_owner_id" {
  description = "The owner ID"
  value       = module.sg_ssh_22.security_group_owner_id
}

output "sg_ssh_22_group_name" {
  description = "The name of the security group"
  value       = module.sg_ssh_22.security_group_name
}

output "sg_ssh_22_group_description" {
  description = "The description of the security group"
  value       = module.sg_ssh_22.security_group_description
}


### VPN ###
output "sg_vpn_id" {
  description = "The ID of sg_vpn"
  value       = module.sg_vpn.security_group_id
}

output "sg_vpn_group_vpc_id" {
  description = "The VPC ID"
  value       = module.sg_vpn.security_group_vpc_id
}

output "sg_vpn_group_owner_id" {
  description = "The owner ID"
  value       = module.sg_vpn.security_group_owner_id
}

output "sg_vpn_group_name" {
  description = "The name of the security group"
  value       = module.sg_vpn.security_group_name
}

output "sg_vpn_group_description" {
  description = "The description of the security group"
  value       = module.sg_vpn.security_group_description
}