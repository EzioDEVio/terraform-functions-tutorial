
variable "environment" {
  description = "The deployment environment (dev, staging, prod)"
  type        = string
}

variable "instance_type_map" {
  type    = map(string)
  default = {
    dev     = "t3.micro"
    staging = "t3.medium"
    prod    = "t3.large"
  }
}
