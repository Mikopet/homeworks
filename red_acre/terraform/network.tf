# availability zones in the region
data "aws_availability_zones" "azs" {
  state = "available"
}

# create a VPC
resource "aws_vpc" "red_acre-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "red_acre-vpc"
  }
}

# create an IGW (so resources can talk to the internet)
resource "aws_internet_gateway" "red_acre-igw" {
  vpc_id = aws_vpc.red_acre-vpc.id

  tags = {
    Name = "red_acre-igw"
  }
}

# create a Route Table for the VPC
resource "aws_route_table" "red_acre-rt-public" {
  vpc_id = aws_vpc.red_acre-vpc.id

  route {
    cidr_block = var.rt_wide_route
    gateway_id = aws_internet_gateway.red_acre-igw.id
  }

  tags = {
    Name = "red_acre-rt-public"
  }
}

# create a Default Route Table for the VPC
# (good practice -- anything not associated with the above
# RT will fall back into this one, so it's not just exposed)
resource "aws_default_route_table" "red_acre-rt-private-default" {
  default_route_table_id = aws_vpc.red_acre-vpc.default_route_table_id

  tags = {
    Name = "red_acre-rt-private-default"
  }
}

# create <count> number of public subnets in each availability zone
resource "aws_subnet" "red_acre-public-subnets" {
  count                   = 2
  cidr_block              = var.public_cidrs[count.index]
  vpc_id                  = aws_vpc.red_acre-vpc.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "red_acre-tf-public-${count.index + 1}"
  }
}

# create <count> number of private subnets in each availability zone
resource "aws_subnet" "red_acre-private-subnets" {
  count             = 2
  cidr_block        = var.private_cidrs[count.index]
  vpc_id            = aws_vpc.red_acre-vpc.id
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "red_acre-tf-private-${count.index + 1}"
  }
}

# associate the public subnets with the public route table
resource "aws_route_table_association" "red_acre-public-rt-assc" {
  count          = 2
  route_table_id = aws_route_table.red_acre-rt-public.id
  subnet_id      = aws_subnet.red_acre-public-subnets.*.id[count.index]
}

# associate the private subnets with the public route table
resource "aws_route_table_association" "red_acre-private-rt-assc" {
  count          = 2
  route_table_id = aws_route_table.red_acre-rt-public.id
  subnet_id      = aws_subnet.red_acre-private-subnets.*.id[count.index]
}

# create security group
resource "aws_security_group" "red_acre-public-sg" {
  name        = "red_acre-public-group"
  description = "access to public instances"
  vpc_id      = aws_vpc.red_acre-vpc.id
}

