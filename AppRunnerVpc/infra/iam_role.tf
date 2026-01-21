resource "aws_iam_role" "app_runner_instance_dynamodb_role" {
  name = "AppRunnerInstanceDynamoDB"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : [
            "ec2.amazonaws.com",
            "tasks.apprunner.amazonaws.com"
          ]
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "app_runner_instance_dynamodb_policy" {
  name = "ddb-Weather"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = ""
        Effect   = "Allow"
        Action   = "dynamodb:*"
        Resource = "arn:aws:dynamodb:${var.aws_region}:${var.aws_account_id}:table/Weather"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_runner_instance_dynamodb_attach" {
  role       = aws_iam_role.app_runner_instance_dynamodb_role.name
  policy_arn = aws_iam_policy.app_runner_instance_dynamodb_policy.arn
}

resource "aws_iam_role_policy_attachment" "dynamodb_full_access" {
  role       = aws_iam_role.app_runner_instance_dynamodb_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_role_policy_attachment" "apprunner_full_access" {
  role       = aws_iam_role.app_runner_instance_dynamodb_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSAppRunnerFullAccess"
}
