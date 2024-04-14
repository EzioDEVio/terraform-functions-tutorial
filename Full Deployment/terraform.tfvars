
# Region where AWS resources will be deployed
region = "us-gov-west-1" # ci_cd_demo  for AWS GovCloud; adjust as needed

# Environment - This could be 'dev', 'staging', or 'prod'
environment = "dev"

# AMI IDs mapping per environment - Ensure these are correct per region and environment
ami_ids = {
  dev     = "ami-123456"  # ci_cd_demo  AMI ID for development
  staging = "ami-654321"  # ci_cd_demo  AMI ID for staging
  prod    = "ami-0abcdef" # ci_cd_demo  AMI ID for production
}

# Instance types mapping per environment
instance_types = {
  dev     = "t3.micro"
  staging = "t3.medium"
  prod    = "t3.large"
}

# CIDR block for the VPC
cidr = "10.0.0.0/16"

# Subnet CIDRs
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
