terraform {
  required_version = ">= 1.4"
  backend "s3" {
    region         = "us-east-1"
    bucket         = "rochescaf-terraform-state"
    key            = "rochescaf.sandbox.json"
    encrypt        = true
    dynamodb_table = "rochescaf-terraform-state"
  }
}

module "global_variables" {
  source = "../modules/global_variables"
}
