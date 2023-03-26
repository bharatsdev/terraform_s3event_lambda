# Terraform create S3 Event as AWS lambda trigger 
Terraform IaC, In this Repo, 
       
        - Create S3 bucket
        - Enable S3 Event
        - Create AWS Lambda
        - Integrate S3 Even with AWS Lambada
        - Add Cloud watch logs with AWS lambda. 
        - Create IAM Role to enable log event for cloud watch.
lambda will capture all the S3 upload Event.
## Tech Stack 
    - Terraform
    - AWS 
    - Nodejs

<!-- Commands -->
### Commands
    terraform init 
    terraform plan
    terraform apply -auto-approve
    terraform destroy -auto-approve
