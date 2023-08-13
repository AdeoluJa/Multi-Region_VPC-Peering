# Create Security Group for EC2 Instance for Requester
resource "aws_security_group" "requester_security_group" {
  provider    = aws.requester
  name        = "requester_security_group"
  description = "requester security group"
  vpc_id      = aws_vpc.requester_vpc.id

  # Allow inbound traffic from Accepter CIDR block
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.accepter_vpc.cidr_block]
  }

  # Allow inbound traffic from Accepter CIDR block
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = [aws_vpc.accepter_vpc.cidr_block]
  }

  # Allow inbound ICMP traffic from Accepter CIDR block
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.accepter_vpc.cidr_block]
  }

  # Allow SSH for EC2 Connect or SSH from a terminal
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "requester_security_group"
  }
}

# Create Security Group for EC2 Instance for Accepter
resource "aws_security_group" "accepter_security_group" {
  provider    = aws.accepter
  name        = "accepter_security_group"
  description = "accepter security group"
  vpc_id      = aws_vpc.accepter_vpc.id

  # Allow inbound traffic from Requester CIDR block
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.requester_vpc.cidr_block]
  }

  # Allow inbound traffic from Requester CIDR block
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = [aws_vpc.requester_vpc.cidr_block]
  }

  # Allow inbound ICMP traffic from Requester CIDR block
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.requester_vpc.cidr_block]
  }

  # Allow SSH from Requester EC2 Instance
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.requester_vpc.cidr_block]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "accepter_security_group"
  }
}