# Whats displayed when terraform is done
output "OpenVPN" {
  value = "OpenVPN public ip address: ${module.vpn_ec2.public_ip[0]}"
}