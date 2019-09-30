terraform {
    backend "s3" {
    region         = "eu-west-1"
    bucket         = "gft-payments-app-backend"
    key            = "terraform.tfstate"
    dynamodb_table = "gft-payments-app-backend"
    encrypt        = "true"
  }
}