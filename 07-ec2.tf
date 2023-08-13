resource "aws_instance" "requester_server" {
  provider        = aws.requester
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.ami_key_pair_name # This is an existing key pair that has already been created in the past
  security_groups = [aws_security_group.requester_security_group.id]
  subnet_id       = aws_subnet.subnet_requester.id
  monitoring      = false

  tags = {
    Name = "requester_server"
  }
}

resource "aws_instance" "accepter_server" {
  provider        = aws.accepter
  ami             = var.ami_id_accepter
  instance_type   = var.instance_type
  key_name        = var.ami_key_pair_name_accepter # This is an existing key pair that has already been created in the past
  security_groups = [aws_security_group.accepter_security_group.id]
  subnet_id       = aws_subnet.subnet_accepter.id
  monitoring      = false

  tags = {
    Name = "accepter_server"
  }
}
