output "aws_target_group_arn" {
  value = aws_lb_target_group.app-lb-tg.arn
  }
output "application_load_balancer_dns_name" {
  value = aws_lb.application-lb.dns_name
}

output "application_load_balancer_zone_id" {
  value = aws_lb.application-lb.zone_id
}
output "aws_lb_subnets" {
  value = aws_lb.application-lb.id
}
output "aws_lb_target_group_id" {
  value = aws_lb_target_group.app-lb-tg.id
}
output "autoscaling_group_name" {
  value = aws_autoscaling_group.TestASG.name
}
