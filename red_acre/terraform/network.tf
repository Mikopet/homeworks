# availability zones in the region
data "aws_availability_zones" "azs" {
  state = "available"
}

# create a VPC
resource "aws_vpc" "red-acre-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "red-acre-vpc"
  }
}

# create an IGW (so resources can talk to the internet)
resource "aws_internet_gateway" "red-acre-igw" {
  vpc_id = aws_vpc.red-acre-vpc.id

  tags = {
    Name = "red-acre-igw"
  }
}

# create a Route Table for the VPC
resource "aws_route_table" "red-acre-rt-public" {
  vpc_id = aws_vpc.red-acre-vpc.id

  route {
    cidr_block = var.rt_wide_route
    gateway_id = aws_internet_gateway.red-acre-igw.id
  }

  tags = {
    Name = "red-acre-rt-public"
  }
}

# create a Default Route Table for the VPC
# (good practice -- anything not associated with the above
# RT will fall back into this one, so it's not just exposed)
resource "aws_default_route_table" "red-acre-rt-private-default" {
  default_route_table_id = aws_vpc.red-acre-vpc.default_route_table_id

  tags = {
    Name = "red-acre-rt-private-default"
  }
}

# create <count> number of public subnets in each availability zone
resource "aws_subnet" "red-acre-public-subnets" {
  count                   = 2
  cidr_block              = var.public_cidrs[count.index]
  vpc_id                  = aws_vpc.red-acre-vpc.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "red-acre-tf-public-${count.index + 1}"
  }
}

# create <count> number of private subnets in each availability zone
resource "aws_subnet" "red-acre-private-subnets" {
  count             = 2
  cidr_block        = var.private_cidrs[count.index]
  vpc_id            = aws_vpc.red-acre-vpc.id
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "red-acre-tf-private-${count.index + 1}"
  }
}

# associate the public subnets with the public route table
resource "aws_route_table_association" "red-acre-public-rt-assc" {
  count          = 2
  route_table_id = aws_route_table.red-acre-rt-public.id
  subnet_id      = aws_subnet.red-acre-public-subnets.*.id[count.index]
}

# associate the private subnets with the public route table
resource "aws_route_table_association" "red-acre-private-rt-assc" {
  count          = 2
  route_table_id = aws_route_table.red-acre-rt-public.id
  subnet_id      = aws_subnet.red-acre-private-subnets.*.id[count.index]
}

# create security group
resource "aws_security_group" "red-acre-public-sg" {
  name        = "red-acre-public-group"
  description = "access to public instances"
  vpc_id      = aws_vpc.red-acre-vpc.id
}

