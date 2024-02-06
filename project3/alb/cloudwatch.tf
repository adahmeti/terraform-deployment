resource "aws_autoscaling_notification" "example_notifications" {
  group_names = [
    aws_autoscaling_group.bar.name,
    aws_autoscaling_group.foo.name,
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = var.aws_sns_topic_arn
}