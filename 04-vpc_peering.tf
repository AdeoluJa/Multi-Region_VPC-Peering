# Create VPC peering connection between both vpcs in different regions in the Requester Region
resource "aws_vpc_peering_connection" "requester" {
  provider    = aws.requester
  vpc_id      = aws_vpc.requester_vpc.id
  peer_vpc_id = aws_vpc.accepter_vpc.id
  peer_region = var.accepter_region
  #auto_accept = false

  tags = {
    Name = "peer_to_accepter"
  }

  depends_on = [
    aws_vpc.requester_vpc,
    aws_vpc.accepter_vpc
  ]
}

# Create VPC peering connection between VPC Peering in the Requester Region and the peering in the Accepter Region
resource "aws_vpc_peering_connection_accepter" "accepter" {
  provider                  = aws.accepter
  vpc_peering_connection_id = aws_vpc_peering_connection.requester.id
  auto_accept               = true

  tags = {
    Name = "peer_to_requester"
  }

  depends_on = [
    aws_vpc.requester_vpc,
    aws_vpc.accepter_vpc
  ]
}
