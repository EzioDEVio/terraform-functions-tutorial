terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0" # Ensure this version is appropriate for your needs
    }
  }
}

provider "aws" {
  region = var.region # Make sure `var.region` is correctly defined in your variables.tf or via CLI
}
