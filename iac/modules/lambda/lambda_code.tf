data "archive_file" "lambda_code" {
  type        = "zip"
  source_dir  = local.source
  output_path = local.output_path
}
locals {
  source      = "src/s3eventlambda"
  output_path = "src/output/s3eventlambda.zip"
}
resource "null_resource" "mainbuild" {
  triggers = {
    updated_at = timestamp()
  }
  provisioner "local-exec" {
    command     = <<EOF
    npm install

    EOF
    working_dir = local.source

  }
}
