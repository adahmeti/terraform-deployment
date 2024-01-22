#     #############
#     # SNS Topic #
#     #############
# resource "aws_sns_topic" "dajmox" {
#   name         = "sns1"
#   display_name = "notification"
# }


#     ####################
#     # SNS Topic Policy #
#     ####################

# resource "aws_sns_topic_policy" "dajmox" {
#   arn = aws_sns_topic.dajmox.arn

#   policy = data.aws_iam_policy_document.sns.json
# }

# data "aws_iam_policy_document" "sns" {
#   statement {
#     actions = [
#       "SNS:Publish"
#     ]
#     principals {
#       type        = "Service"
#       identifiers = ["codepipeline.amazonaws.com"]
#     }
#     resources = [
#       aws_sns_topic.dajmox.arn
#     ]
#     condition {
#       test     = "ArnEquals"
#       variable = "aws:SourceArn"
#       values   = [aws_codepipeline.dajmoxx.arn]
#     }
#   }
# }


# #     ####################
# #     # SNS Subscription #
# #     ####################

# # resource "aws_sns_topic_subscription" "sns" {
# #   topic_arn = aws_sns_topic.dajmox.arn
# #   protocol  = "email"
# #   endpoint  = "adenis.ahmeti@polymaths.co"
# # }