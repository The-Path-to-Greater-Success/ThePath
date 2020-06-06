locals {
  queue-name = "create-user-queue"
  max-message-size = 2048
}

resource "aws_sqs_queue" "create-user-queue-dlq" {
  name = format("%s-dlq", local.queue-name)
  max_message_size = local.max-message-size
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "create-user-queue" {
  name                      = local.queue-name
  max_message_size          = local.max-message-size
  message_retention_seconds = 1209600
  receive_wait_time_seconds = 10
  redrive_policy            = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.create-user-queue-dlq.arn
    maxReceiveCount     = 3
  })

  tags = {
    Environment = var.Environment
  }
}