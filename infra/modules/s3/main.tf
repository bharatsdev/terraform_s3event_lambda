resource "aws_s3_bucket" "my_test_s3" {
  bucket        = var.bucket_name
  force_destroy = true
  depends_on = [
    var.event_lambda
  ]
}

resource "aws_s3_bucket_acl" "s3_acl" {
  bucket = aws_s3_bucket.my_test_s3.id
  acl    = "private"
}

resource "aws_s3_bucket_notification" "s3_notification" {
  bucket = aws_s3_bucket.my_test_s3.id
  lambda_function {
    lambda_function_arn = var.event_lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }
  # depends_on = [
  #   var.event_lambda
  # ]
}
# Invoke Persimmion

resource "aws_lambda_permission" "s3_invoke_lambda" {
  depends_on = [
    var.event_lambda,
    aws_s3_bucket.my_test_s3
  ]
  statement_id  = "Allows3ToInvokeLambdafuncation"
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.my_test_s3.arn
  function_name = var.event_lambda.function_name
  action        = "lambda:InvokeFunction"
}
