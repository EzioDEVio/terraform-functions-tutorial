
terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"  # Specify the name of the S3 bucket
    key            = "statefile.tfstate"  # Path to the state file within the bucket
    region         = "us-east-1"  # The AWS region for your S3 bucket
    dynamodb_table = "terraform-lock-table"  # DynamoDB table for state locking
    encrypt        = true  # Enable server-side encryption
  }
}
