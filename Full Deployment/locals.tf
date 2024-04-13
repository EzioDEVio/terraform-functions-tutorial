
locals {
  common_tags = {
    Terraform = "true"
    Environment = var.environment
  }
}
