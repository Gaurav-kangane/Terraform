provider "aws" {
  region = "ap-south-1"   #default
}

provider "aws" {
  region = "us-east-1"
  alias = "N_virginia"
}