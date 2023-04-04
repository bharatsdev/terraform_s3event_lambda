# Cloudwatch log group for logging the lambda event and data for labmda execution
resource "aws_cloudwatch_log_group" "lambda_loggroup" {
  name              = local.loggroup_name
  retention_in_days = 3
  lifecycle {
    prevent_destroy = false
  }
}

# Cloud Watch log group name
locals {
  loggroup_name = "/aws/lambda/${var.function_name}"
}

variable "function_name" {
  
}