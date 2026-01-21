# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get the main route table for the default VPC
data "aws_route_table" "main" {
  vpc_id = data.aws_vpc.default.id

  filter {
    name   = "association.main"
    values = ["true"]
  }
}

# Create VPC Endpoint for DynamoDB
resource "aws_vpc_endpoint" "vpc_endpoint_dynamodb" {
  vpc_id          = data.aws_vpc.default.id
  service_name    = "com.amazonaws.${var.aws_region}.dynamodb"
  route_table_ids = [data.aws_route_table.main.id]

  tags = {
    Name = "vpc-endpoint-dynamodb"
  }
}
