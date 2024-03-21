######################################################
# Application-Load-Balancer
######################################################

resource "aws_lb" "application-lb" {

  name               = "ecommerce-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.loadbalancer_security_group]
  subnets            = [var.subnet1, var.subnet2]
  tags = {
    Name = "Webservers-LB"
  }
}

######################################################
# Target-Group
######################################################

resource "aws_lb_target_group" "app-lb-tgr" {

  name        = "app-lb-tgr"
  port        = 80
  target_type = "instance"
  vpc_id      = var.vpc_id
  protocol    = "HTTP"
  health_check {
    enabled  = true
    interval = 10
    path     = "/"
    port     = 80
    protocol = "HTTP"
    matcher  = "200-399"
  }
  tags = {
    Name = "webserver-target-group"
  }
}

##########################################################################
# Load-Balancer-listener for HTTP 
##########################################################################

resource "aws_lb_listener" "lb-https-listener" {

  load_balancer_arn = aws_lb.application-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-lb-tgr.arn
  }
}


####################################
#  Launch Template     
####################################

resource "aws_launch_template" "LT-demo" {
 
  name = "acrapovici"
  description = "My launch template"  
  image_id = "ami-09ca61dde3dc883d0"
  instance_type = "t3.micro"
  instance_initiated_shutdown_behavior = "terminate"
  key_name = "abkey"
  ebs_optimized = true
  update_default_version = true

  network_interfaces {
    associate_public_ip_address = true
     security_groups             = [var.LT-SG]
  }


  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 20
      delete_on_termination = true
      volume_type = "gp2"
    }
  }

  
  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Akrapovic"
    }
  }

}

#########################################################
# ALB attachment wth ASG

resource "aws_autoscaling_attachment" "AlbAsg" {
  autoscaling_group_name = aws_autoscaling_group.TestASG.id
  lb_target_group_arn    = aws_lb_target_group.app-lb-tgr.arn
}


resource "aws_autoscaling_group" "TestASG" {
  vpc_zone_identifier = [var.subnet1, var.subnet2]
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  

  launch_template {
    id      = aws_launch_template.LT-demo.id
    version = aws_launch_template.LT-demo.latest_version #"$Latest"
  }
 
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"

}



# scale up alarm
# alarm will trigger the ASG policy (scale/down) based on the metric (CPUUtilization), comparison_operator, threshold
resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_name          = "Asg-scale-up-alarm"
  alarm_description   = "Asg-scale-up-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70" # New instance will be created once CPU utilization is higher than 70 %
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.TestASG.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_down.arn]
}

# scale down policy
resource "aws_autoscaling_policy" "scale_down" {
  name                   = "Asg-scale-down"
  autoscaling_group_name = aws_autoscaling_group.TestASG.name
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "TargetTrackingScaling"
  estimated_instance_warmup = 200
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 70
    
  }
}


# scale down alarm
resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_name          = "Asg-scale-down-alarm"
  alarm_description   = "asg-scale-down-cpu-alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70" # Instance will scale down when CPU utilization is lower than 70 %
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.TestASG.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_down.arn]
}
