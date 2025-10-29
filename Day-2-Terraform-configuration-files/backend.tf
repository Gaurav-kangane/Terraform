terraform {
  backend "s3" {
        bucket = "kangane"
        key = "Day-2/terraform.tfstate"
        region = "ap-south-1"
  }
}