terraform {
  backend "s3" {
    bucket         = "kubical-aws-org-root-tf-state-eu-west-1"
    key            = "admin-global/terraform.tfstate"
    dynamodb_table = "terraform-state-lock"
    region         = "eu-west-1"
    encrypt        = "true"
  }
}
