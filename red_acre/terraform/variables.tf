variable "vpc_cidr" {
  description = "The CIDR Block for the VPC"
  default     = "10.0.0.0/16"
}

variable "rt_wide_route" {
  description = "Route in the Route Table"
  default     = "0.0.0.0/0"
}

variable "public_cidrs" {
  description = "Public Subnet CIDR Blocks"
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "private_cidrs" {
  description = "Private Subnet CIDR Blocks"
  default = [
    "10.0.3.0/24",
    "10.0.4.0/24"
  ]
}