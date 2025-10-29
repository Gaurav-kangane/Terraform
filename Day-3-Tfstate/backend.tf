#we are adding tfstate file to s3 bucket for avoid conflicts

terraform {
  backend "s3" {
        bucket = "kangane"
        key = "Day-3/terraform.tfstate"
        region = "ap-south-1"
  }
}