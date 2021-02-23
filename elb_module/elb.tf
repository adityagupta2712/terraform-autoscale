resource "aws_lb" "elb_test" {
  name               = "elbtest"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = [var.public_subnet_id_1, var.public_subnet_id_2, var.public_subnet_id_3]

  enable_deletion_protection = false
  tags = {
    Environment = "elb-test"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.elb_test.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn

  }
}

resource "aws_lb_target_group" "test" {
  name     = "tf-test-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_test_id
}

output "lb_tg" {
  description = "The DNS name of the ELB"
  value       = aws_lb_target_group.test.arn
}

output "elb_test" {
  description = "The DNS name of the ELB"
  value       = aws_lb.elb_test.id
}
