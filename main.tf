module "my_s3" {
  source       = "./iac/modules/s3"
  bucket_name  = var.bucket_name
  event_lambda = module.my_lambda.event_lambda
}

module "my_lambda" {
  source = "./iac/modules/lambda"
}
module "cloud-watch" {
  source        = "./iac/modules/cloudwatch"
  function_name = module.my_lambda.event_lambda.function_name
}
