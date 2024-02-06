######################################################
# Application-Load-Balancer
######################################################

resource "aws_lb" "application-lb" {

  name               = "webservers-lb"
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

resource "aws_lb_target_group" "app-lb-tg" {

  name        = "app-lb-tg"
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
# Load-Balancer-listener for HTTP AND HTTPS
##########################################################################

resource "aws_lb_listener" "lb-https-listener" {

  load_balancer_arn = aws_lb.application-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-lb-tg.arn
  }
}


####################################
#  Launch Template     
####################################

resource "aws_launch_template" "aws_launch_template" {
 
  name = "dajmox-lt"
  description = "My launch template"  
  image_id = "ami-0277155c3f0ab2930"
  instance_type = "t2.micro"
  instance_initiated_shutdown_behavior = "terminate"
  key_name = "abckey"
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
      Name = "test"
    }
  }

  user_data = filebase64("${path.module}/example.sh")
}


resource "aws_autoscaling_group" "example" {
  vpc_zone_identifier = [var.subnet1, var.subnet2]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.aws_launch_template.id
      }

      override {
        instance_requirements {
          memory_mib {
            min = 1000
          }

          vcpu_count {
            min = 4
          }
        }
      }
    }
  }
}

resource "aws_autoscaling_policy" "high_cpu" {
  name                   = "high-cpu"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.example.name 
}


# resource "aws_cloudwatch_metric_alarm" "app1_asg_cwa_cpu" {
#   alarm_name          = "CWA-CPUUtilization"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = "120"
#   statistic           = "Average"
#   threshold           = "80"
#   alarm_description = "This metric monitors ec2 cpu utilization and triggers the ASG Scaling policy to scale-out if CPU is above 80%"

#   dimensions = {
#     AutoScalingGroupName = aws_autoscaling_group.example.name 
#   }


#     alarm_actions     = [
#      "arn:aws:sns:us-east-1:53123789012:Topic"
#     ]
# }