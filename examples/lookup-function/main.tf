
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = lookup(var.instance_type_map, var.environment, "t3.micro")

  tags = {
    Name = "Server-${var.environment}"
  }
}
