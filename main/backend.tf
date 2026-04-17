terraform {
  backend "s3" {
    bucket         = "my-tf-state-bucket-unique-67890"
    key            = "eks/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
