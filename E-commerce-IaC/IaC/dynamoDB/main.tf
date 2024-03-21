resource "aws_dynamodb_table" "dynamtabledb" {
  name           = "DynamoDBcreatedwithTerraform"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"
  range_key      = "Name"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "Name"
    type = "S"
  }
}