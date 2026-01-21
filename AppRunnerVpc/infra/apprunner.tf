# ECR Access Role - allows App Runner to pull images from ECR
resource "aws_iam_role" "app_runner_ecr_access_role" {
  name = "AppRunnerECRAccessRole"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "build.apprunner.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_runner_ecr_access" {
  role       = aws_iam_role.app_runner_ecr_access_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}

resource "aws_apprunner_vpc_connector" "app_runner_vpc_connector" {
  vpc_connector_name = "AppRunnerDynamoDB"
  subnets            = ["subnet-0e126b58e438ba098", "subnet-06608cf7016ba91fc", "subnet-06515d469b62cd86a"]
  security_groups    = ["sg-00ee9eb7f05513fca"]
}

resource "aws_apprunner_service" "app_runner_service" {
  service_name = "HelloAppRunnerVpc"

  source_configuration {
    image_repository {
      image_configuration {
        port = "8080"
      }
      image_identifier      = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/apprunnervpc:latest"
      image_repository_type = "ECR"
    }
    authentication_configuration {
      access_role_arn = aws_iam_role.app_runner_ecr_access_role.arn
    }

    auto_deployments_enabled = true
  }

  instance_configuration {
    instance_role_arn = aws_iam_role.app_runner_instance_dynamodb_role.arn
  }

  network_configuration {
    egress_configuration {
      egress_type       = "VPC"
      vpc_connector_arn = aws_apprunner_vpc_connector.app_runner_vpc_connector.arn
    }
  }
}