# Returns this back to the module calling it
# The information can later be used with other resources
output "public_ip" {
  description = "Public ip address"
  value = module.ec2_cluster.public_ip
}