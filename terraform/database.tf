variable "Environment" {
  description = "The environment for the infrastucture. Examples are \"DEV\". \"TST\""
  type = string
}

variable "Region" {
  description = "Region for the infrastructure. Example: eu-central-1"
  type = string
}

provider "aws" {
  profile    = "default"
  region     = var.Region
}

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
