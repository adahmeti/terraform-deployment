resource "aws_sns_topic" "topic" {
  name = "SNS-email-notification"
}

resource "aws_sns_topic_subscription" "email-target" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "email"
  endpoint  = "adenis.ahmeti@polymaths.co"
}