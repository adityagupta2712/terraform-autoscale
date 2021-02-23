resource "aws_launch_configuration" "launch_config" {
  name            = "web_config"
  image_id        = var.ami_id
  instance_type   = "t3.micro"
  key_name        = "terraform-key"
  security_groups = [aws_security_group.ec2_sg.id]
  user_data       = file("ec2_module/script.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "test_autoscaling" {
  name                      = "autoscaling-terraform-test"
  max_size                  = 10
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 3
  force_delete              = true
  launch_configuration      = aws_launch_configuration.launch_config.name
  #availability_zones       = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  vpc_zone_identifier = [var.public_subnet_id_1, var.public_subnet_id_2, var.public_subnet_id_3]

  tag {
    key                 = "Name"
    value               = "terraform-asg-test"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_elb" {
  autoscaling_group_name = aws_autoscaling_group.test_autoscaling.id
  alb_target_group_arn   = var.lb_tg
}

resource "aws_autoscaling_policy" "asp" {
  name                   = "asp-terraform-test"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  policy_type            = "SimpleScaling"
  autoscaling_group_name = aws_autoscaling_group.test_autoscaling.name
}

resource "aws_cloudwatch_metric_alarm" "aws_cloudwatch_metric_alarm" {
  alarm_name          = "terraform-test-cloudwatch"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"
  alarm_description   = "This metric monitors ec2 cpu utilization"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.test_autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.asp.arn]

}

resource "aws_sns_topic" "user_updates" {
  name         = "user-updates-topic"
  display_name = "example auto scaling"
}

resource "aws_autoscaling_notification" "test_notifications" {
  group_names = [aws_autoscaling_group.test_autoscaling.name]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.user_updates.arn
}
