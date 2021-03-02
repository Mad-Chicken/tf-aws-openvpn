variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_profile" {
  type    = string
  default = ""
}

### VPC ###
# Private subnet  : 10.0.1.0/24
# Public subnet   : 10.0.2.0/24
# VPN User Subnet : 10.0.99.0/24
variable "vpc_name" {
  type    = string
  default = "vpc-test"
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_azs" {
  type    = list(string)
  default = ["us-east-1a"]
}

variable "vpc_private_subnet" {
  type    = list(string)
  default = ["10.0.1.0/24","10.0.99.0/24"]
}

variable "vpn_subnet" {
  type        = string
  description = "describe your variable"
  default     = "10.0.99.0"
}

variable "vpc_public_subnet" {
  type    = list(string)
  default = ["10.0.2.0/24"]
}


### EC2 OpenVPN-as ###
variable "vpn_ami" {
	type    = string
	default = "ami-0885b1f6bd170450c"
}

variable "vpn_size" {
	type    = string
	default = "t2.micro"
}

variable "openvpn-passwd" {
	type    = string
	default = "passwd"
}

variable "ec2_ssh_key" {
	type        = string
	default     = "ec2_ssh_key"
	description = "SSH key name stored in ec2 keypairs"
}

variable "vpn_username" {
  type    = string
  default = "foo"
}

variable "vpn_password" {
  type        = string
  description = "describe your variable"
  default     = "bar"
}


### EC2 Pihole ###
variable "pihole_ami" {
  type    = string
  default = "ami-0885b1f6bd170450c"
}

variable "pihole_size" {
  type    = string
  default = "t2.micro"
}

variable "pihole_private_ip" {
  type    = string
  default = "10.0.1.100"
}

# Create #
variable "piholeYN" {
  type = string
  description = "Pihole (Y/n):  "
}