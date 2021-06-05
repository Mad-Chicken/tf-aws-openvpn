variable "aws_region" {
  type    = string
  default = "us-east-1"
  description = "Default aws region to use"
}

variable "aws_profile" {
  type    = string
  default = ""
  description = "Which aws account is running the commands"
}

### VPC ###
# Private subnet  : 10.0.1.0/24
# Public subnet   : 10.0.2.0/24
# VPN User Subnet : 10.0.99.0/24
variable "vpc_name" {
  type    = string
  default = "cit252_vpn_vpc"
  description = "What the vpc name should be"
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
  description = "What the vpc cidr should be"
}

variable "vpc_azs" {
  type    = list(string)
  default = ["us-east-1a"]
  description = "The availability zone to create the subnets in"
}

variable "vpc_private_subnet" {
  type    = list(string)
  default = ["10.0.1.0/24","10.0.99.0/24"]
  description = "Private subnet cidr"
}

variable "vpc_public_subnet" {
  type    = list(string)
  default = ["10.0.2.0/24"]
  description = "cidr for public subnet"
}

variable "vpn_subnet" {
  type        = string
  description = "Public subnet cidrs used for OpenVPN to use as variable"
  default     = "10.0.99.0"
}

### EC2 OpenVPN-as ###
variable "vpn_ami" {
	type    = string
	default = "ami-0885b1f6bd170450c"
  description = "The ami being used for the vpn server"
}

variable "vpn_size" {
	type    = string
	default = "t2.micro"
  description = "The server type being used for the vpn server"
}

variable "openvpn-passwd" {
	type    = string
	default = "passwd"
  description = "Password for the OpenVPN admin"
}

variable "ec2_ssh_key" {
	type        = string
	default     = "ec2_ssh_key"
	description = "SSH key name stored in ec2 keypairs"
}

variable "vpn_username" {
  type    = string
  default = "foo"
  description = "Username for the OpenVPN user"
}

variable "vpn_password" {
  type        = string
  default     = "bar"
  description = "Password for the OpenVPN user"
}


### EC2 Pihole ###
variable "pihole_ami" {
  type    = string
  default = "ami-0885b1f6bd170450c"
  description = "The ami for the pihole server"
}

variable "pihole_size" {
  type    = string
  default = "t2.micro"
  description = "The server type being used for the pihole server"
}

variable "pihole_private_ip" {
  type    = string
  default = "10.0.1.100"
  description = "The private ip address for the pihole"
}

# Create #
variable "piholeYN" {
  type = string
  description = "Pihole (Y/n):  "
}