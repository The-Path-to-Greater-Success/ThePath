resource "aws_dynamodb_table" "dynamoDB-users-table" {
  name = "Users"
  hash_key = "UserId"
  billing_mode = "PROVISIONED"
  read_capacity = 5
  write_capacity = 5

  attribute {
    name = "UserId"
    type = "S"
  }

  tags = {
    Environment = var.Environment
  }
}
