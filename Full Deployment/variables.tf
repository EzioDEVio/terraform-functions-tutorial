
variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

variable "region" {
  description = "AWS region to deploy the resources"
  default     = "us-east-1"
}

variable "ami_ids" {
  description = "Map of AMIs for each environment"
  type        = map(string)
  default = {
    dev     = "ami-123456"  # ci_cd_demo  AMI ID for development
    staging = "ami-654321"  # ci_cd_demo  AMI ID for staging
    prod    = "ami-0abcdef" # ci_cd_demo  AMI ID for production
  }
}

variable "instance_types" {
  description = "EC2 instance types for each environment"
  type        = map(string)
  default = {
    dev     = "t3.micro"
    staging = "t3.medium"
    prod    = "t3.large"
  }
}

variable "cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}



variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets for each environment"
  type = map(list(string))
  default = {
    dev     = ["10.0.1.0/24", "10.0.2.0/24"]
    staging = ["10.1.1.0/24", "10.1.2.0/24"]
    prod    = ["10.2.1.0/24", "10.2.2.0/24"]
  }
}
