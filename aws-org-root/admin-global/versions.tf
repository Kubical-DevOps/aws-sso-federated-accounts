terraform {
  required_version = "1.0.9"

  required_providers {
    aws      = "3.64.0"
    template = "2.2.0"
  }
}

provider "aws" {
  region = var.region
}
