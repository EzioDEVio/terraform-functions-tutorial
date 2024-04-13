
provider "aws" {
  region = "us-east-1"
}

locals {
  common_tags = {
    Owner       = "Network Team"
    Environment = var.environment
  }
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"

  tags = merge(
    {
      Name = "MainVPC-${var.environment}"
    },
    local.common_tags
  )
}
