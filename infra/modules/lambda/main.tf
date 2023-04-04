resource "aws_lambda_function" "s3_event_lambda" {
  function_name    = "s3eventlambda"
  handler          = "index.handler"
  runtime          = "nodejs18.x"
  role             = aws_iam_role.lambda_iam_role.arn
  filename         = data.archive_file.lambda_code.output_path
  source_code_hash = data.archive_file.lambda_code.output_base64sha256
}

# Attache IAM assume role to lambda
resource "aws_iam_role" "lambda_iam_role" {
  assume_role_policy = data.aws_iam_policy_document.assim_role_doc.json
}

# Attach cloud watch loggin policy to lambda IAM role
resource "aws_iam_role_policy_attachment" "attach_logging_policy" {
  role       = aws_iam_role.lambda_iam_role.id
  policy_arn = aws_iam_policy.loggroup_policy.arn
}

# Assume Role Policies
data "aws_iam_policy_document" "assim_role_doc" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
# Cloudwatch Permission Policies
resource "aws_iam_policy" "loggroup_policy" {
  policy = data.aws_iam_policy_document.cloudwatch_log_permission_doc.json
}

# Assume Role Policies
data "aws_iam_policy_document" "cloudwatch_log_permission_doc" {
  statement {
    effect    = "Allow"
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["arn:aws:logs:*:*:*"]
  }
}
