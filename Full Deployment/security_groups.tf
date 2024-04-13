
resource "aws_security_group" "ci_cd_demo" {
  name        = "ci_cd_demo-${var.environment}"
  description = "Security group for environment ${var.environment}"
  vpc_id      = aws_vpc.ci_cd_demo_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "sg-${var.environment}"
  }, local.common_tags)
}