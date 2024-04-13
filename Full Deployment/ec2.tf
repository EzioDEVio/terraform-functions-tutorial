
resource "aws_instance" "ci_cd_demo " {
  ami           = lookup(var.ami_ids, var.environment)
  instance_type = lookup(var.instance_types, var.environment, "t3.micro")
  subnet_id     = element(aws_subnet.public_subnet.*.id, 0)
  vpc_security_group_ids = [aws_security_group.ci_cd_demo .id]

  tags = merge({
    Name = "Instance-${var.environment}"
  }, local.common_tags)
}
