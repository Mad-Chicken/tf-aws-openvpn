variable "vpc_name" {
	type    = string
	default = ""
}

variable "cidr" {
	type = string
}

variable "vpc_azs" {
  type = list(string)
}

variable "vpc_private_subnet" {
	type = list(string)
}

variable "vpc_public_subnet" {
	type = list(string)
}

variable "enable_nat_gateway" {
  type = string
  description = "enable_nat_gateway"
}

variable "single_nat_gateway" {
  type = string
  description = "single_nat_gateway"
}