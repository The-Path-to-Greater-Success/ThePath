data "aws_iam_policy_document" "assume-role-lambda-policy" {
  statement {
    effect = "Allow"
    actions = [
    "sts:AssumeRole"
    ]
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type = "Service"
    }
  }
}

data "aws_iam_policy_document" "create-user-lambda-policy" {
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:PutItem"
    ]
    resources = [var.dynamoDB-users-table-arn]
  }
  statement {
    effect = "Allow"
    actions = [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes"
    ]
    resources = [var.create-user-queue-arn]
  }
}

resource "aws_iam_policy" "create-user-lambda-policy" {
  name = format("create-user-lambda-%s", var.Environment)
  policy = data.aws_iam_policy_document.create-user-lambda-policy.json
}

resource "aws_iam_role" "create-user-lambda-role" {
  name = "create-user-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume-role-lambda-policy.json
}

resource "aws_iam_role_policy_attachment" "create-user-policy-role-attachment" {
  policy_arn = aws_iam_policy.create-user-lambda-policy.arn
  role = aws_iam_role.create-user-lambda-role.name
}
