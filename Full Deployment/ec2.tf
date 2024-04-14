resource "aws_instance" "ci_cd_demo" {
  ami                    = lookup(var.ami_ids, var.environment)
  instance_type          = lookup(var.instance_types, var.environment, "t3.micro")
  subnet_id              = aws_subnet.public_subnet[0].id # Assumes use of the first subnet; adjust as necessary
  vpc_security_group_ids = [aws_security_group.ci_cd_demo.id]

  tags = merge({
    Name = "Instance-${var.environment}"
  }, local.common_tags)
}

# For deploying same EC2 instance into private subnet modify the subnet_id to point to private subnet

#resource "aws_instance" "ci_cd_demo" {
  #ami                    = lookup(var.ami_ids, var.environment)
  #instance_type          = lookup(var.instance_types, var.environment, "t3.micro")
  #subnet_id              = aws_subnet.private_subnet[0].id # Now using the first private subnet
  #vpc_security_group_ids = [aws_security_group.ci_cd_demo.id]

  #tags = merge({
   # Name = "Instance-${var.environment}"
 # }, local.common_tags)
#}


# bastion host: ec2 instance to access private instances. 


resource "aws_instance" "bastion_host" {
  ami           = lookup(var.ami_ids, "bastion")  // Make sure to have an AMI for bastion hosts
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet[0].id // Assumes the first defined public subnet is used

  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  key_name = "your-key-pair-name"  // Ensure you have a key pair created and available

  tags = merge({
    Name = "BastionHost-${var.environment}"
  }, local.common_tags)
}

resource "aws_security_group" "bastion_sg" {
  name        = "sg-bastion-${var.environment}"
  description = "Security Group for Bastion Host"
  vpc_id      = aws_vpc.ci_cd_demo_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["your-ip-address/32"]  // Your office or home IP to restrict access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-bastion-${var.environment}"
    Terraform = "true"
    Environment = var.environment
  }
}
