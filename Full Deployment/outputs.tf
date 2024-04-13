
output "instance_id" {
  value = aws_instance.ci_cd_demo.id
}

output "security_group_id" {
  value = aws_security_group.ci_cd_demo.id
}

output "vpc_id" {
  value = aws_vpc.ci_cd_demo_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
}
