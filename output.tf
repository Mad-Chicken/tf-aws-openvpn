# Whats displayed when terraform is done
output "OpenVPN" {
  value = module.vpn_ec2.public_ip[0]
}