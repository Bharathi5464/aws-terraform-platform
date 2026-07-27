terraform {

  backend "s3" {

    bucket         = "bharathi-terraform-bootstrap-state"       # S3 bucket used to store the Terraform remote state file
    key            = "aws-terraform-platform/terraform.tfstate" # Path (object key) of the state file inside the S3 bucket
    region         = "ap-south-1"                               # AWS Region where the S3 bucket and DynamoDB table are located
    dynamodb_table = "terraform-bootstrap-lock"                 # DynamoDB table used for Terraform state locking
    encrypt        = true                                       # Encrypt the Terraform state file stored in the S3 bucket
  }
}
