# Create VPC for Requester
resource "aws_vpc" "requester_vpc" {
  cidr_block = var.vpc_cidr_block
  provider   = aws.requester
  #  enable_dns_hostnames = true
  tags = {
    Name = "requester_vpc"
  }
}

# Create Internet Gateway for Requester
resource "aws_internet_gateway" "requester-igw" {
  vpc_id   = aws_vpc.requester_vpc.id
  provider = aws.requester
  tags = {
    Name = "requester-igw"
  }
}

# Create Route Table for Requester
resource "aws_route_table" "route_table_requester" {
  vpc_id   = aws_vpc.requester_vpc.id
  provider = aws.requester

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.requester-igw.id
  }

  route {
    cidr_block                = "10.1.5.0/24"
    vpc_peering_connection_id = aws_vpc_peering_connection.requester.id
  }
}

# Data for availability Zones
data "aws_availability_zones" "availability_zones" {
  provider = aws.requester
}

# Create Subnet for Requester
resource "aws_subnet" "subnet_requester" {
  provider                = aws.requester
  vpc_id                  = aws_vpc.requester_vpc.id
  cidr_block              = var.requester_subnet_cidr_block
  map_public_ip_on_launch = true # This makes public subnet
  availability_zone       = data.aws_availability_zones.availability_zones.names[0]
  tags = {
    Name = "requester-subnet"
  }
}

# Associate Requester Subnet to Requester Route Table
resource "aws_route_table_association" "route_table_requester" {
  provider       = aws.requester
  subnet_id      = aws_subnet.subnet_requester.id
  route_table_id = aws_route_table.route_table_requester.id
}
