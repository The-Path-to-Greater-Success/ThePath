variable "Environment" {
  description = "The environment for the infrastucture. Examples are \"DEV\". \"TST\""
  type = string
}

variable "dynamoDB-users-table-arn" {
  type = string
}

variable "create-user-queue-arn" {
  type = string
}