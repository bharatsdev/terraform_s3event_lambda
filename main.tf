module "get_s3_notification_lambda" {
  source = "./infra/modules/lambda"
}

module "file_upload_s3" {
  source       = "./infra/modules/s3"
  bucket_name  = var.bucket_name
  event_lambda = module.get_s3_notification_lambda.event_lambda
}

module "get_notification_cloud_watch" {
  source        = "./infra/modules/cloudwatch"
  function_name = module.get_s3_notification_lambda.event_lambda.function_name
}
