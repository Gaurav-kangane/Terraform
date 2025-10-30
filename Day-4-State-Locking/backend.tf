terraform {
  backend "s3" {
        bucket = "kangane"
        key = "day-4/terraform.tfstate"
        use_lockfile = true
        region = "ap-south-1"
  }
}