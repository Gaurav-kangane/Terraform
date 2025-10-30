terraform {
  backend "s3" {
        bucket = "kangane"
        key = "day-4/terraform.tfstate"
        #use_lockfile = true         #to use s3 native locking 1.19 version above
        region = "ap-south-1"
        dynamodb_table = "Gaurav"    # any version we can use dynamobd locking
        encrypt = true
  }
}