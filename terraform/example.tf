provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

resource "aws_sqs_queue" "test_terarform_queue" {
  name = "terraform-test-sqs"
  max_message_size = 2048

  tags = {
    Environment = "dev"
  }
}