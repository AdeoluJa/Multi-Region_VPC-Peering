provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.requester_region
}

# Provider for Requester
provider "aws" {
  alias      = "requester"
  region     = var.requester_region
  access_key = var.access_key
  secret_key = var.secret_key
}

# Provider for Accepter 
provider "aws" {
  alias      = "accepter"
  region     = var.accepter_region
  access_key = var.access_key
  secret_key = var.secret_key
}


terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
