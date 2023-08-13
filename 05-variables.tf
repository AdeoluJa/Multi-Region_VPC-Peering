variable "access_key" {
  description = "The Access Key"
  default     = [{}]
}

variable "secret_key" {
  description = "The Secret Key"
  default     = [{}]
}

variable "requester_region" {
  type    = string
  default = "eu-west-1"
}

variable "accepter_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "VPC Cidr Block"
  default     = "10.0.0.0/16"
}

variable "peer_vpc_cidr_block" {
  description = "Peer VPC Cidr Block"
  default     = "10.1.0.0/16"
}

variable "requester_subnet_cidr_block" {
  description = "Requester Subnet Cidr Block"
  default     = "10.0.5.0/24"
}

variable "accepter_subnet_cidr_block" {
  description = "Accepter Subnet Cidr Block"
  default     = "10.1.5.0/24"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami_id" {
  type    = string
  default = "ami-0136ddddd07f0584f"
}

variable "ami_key_pair_name" {
  type    = string
  default = "peering"
}

variable "ami_id_accepter" {
  type    = string
  default = "ami-0261755bbcb8c4a84"
}

variable "ami_key_pair_name_accepter" {
  type    = string
  default = "peering_2"
}
