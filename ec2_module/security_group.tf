resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_test_id

  ingress {
    # SSH Port 22 allowed from any IP
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [var.security_group_elb]
  }
  ingress {
    # SSH Port 22 allowed from any IP
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #update this with your IP
  }
  ingress {
    # SSH Port 22 allowed from any IP
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.security_group_elb]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ec2_sg"
  }
}

output "security_group_ec2" {
  value = aws_security_group.ec2_sg.id
}
