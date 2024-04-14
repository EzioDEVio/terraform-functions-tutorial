
resource "aws_security_group" "ci_cd_demo" {
  name        = "ci_cd_demo-${var.environment}"
  description = "Security group for environment ${var.environment}"
  vpc_id      = aws_vpc.ci_cd_demo_vpc.id

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules

    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = merge({
    "Name" = "sg-${var.environment}"
  }, local.common_tags)
}
