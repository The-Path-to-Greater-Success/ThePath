module "users-database-table" {
  source = "./modules/table"
  Environment = var.Environment
  Region = var.Region
}

module "create-user-lambda-role" {
  source = "./modules/iam-policies"
  dynamoDB-users-table-arn = module.users-database-table.dynamoDB-users-table-arn
}

resource "aws_lambda_function" "create-user-lambda" {
  function_name = "create-user-lambda"
  handler = "CreateUserLambda::CreateUserLambda.Function::FunctionHandler"
  role = module.create-user-lambda-role.create-user-lambda-role-arn
  runtime = "dotnetcore2.1"
  filename = "../../backend/CreateUserLambda/bin/Release/netcoreapp2.1/CreateUserLambda.zip"

  tags = {
    Environment = var.Environment
  }
}
