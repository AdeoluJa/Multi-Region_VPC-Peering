# Create VPC for Accepter
resource "aws_vpc" "accepter_vpc" {
  cidr_block = var.peer_vpc_cidr_block
  provider   = aws.accepter
  #  enable_dns_hostnames = true
  tags = {
    Name = "accepter_vpc"
  }
}

# Create Internet Gateway for Accepter
resource "aws_internet_gateway" "accepter-igw" {
  vpc_id   = aws_vpc.accepter_vpc.id
  provider = aws.accepter
  tags = {
    Name = "accepter-igw"
  }
}

# Create Route Table for Accepter
resource "aws_route_table" "route_table_accepter" {
  vpc_id   = aws_vpc.accepter_vpc.id
  provider = aws.accepter

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.accepter-igw.id
  }

  route {
    cidr_block                = "10.0.5.0/24"
    vpc_peering_connection_id = aws_vpc_peering_connection.requester.id
  }
}

# Data for availability Zones
data "aws_availability_zones" "azs" {
  provider = aws.accepter
}

# Create Subnet for Accepter
resource "aws_subnet" "subnet_accepter" {
  provider                = aws.accepter
  vpc_id                  = aws_vpc.accepter_vpc.id
  cidr_block              = var.accepter_subnet_cidr_block
  map_public_ip_on_launch = false # This makes private subnet
  availability_zone       = data.aws_availability_zones.azs.names[1]
  tags = {
    Name = "accepter-subnet"
  }
}

# Associate Accepter Subnet to Accepter Route Table
resource "aws_route_table_association" "route_table_accepter" {
  provider       = aws.accepter
  subnet_id      = aws_subnet.subnet_accepter.id
  route_table_id = aws_route_table.route_table_accepter.id
}
