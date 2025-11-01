resource "aws_vpc" "name" {
        cidr_block = "10.0.0.0/16"
        tags = {
          Name = "gsk"
        }
}

resource "aws_s3_bucket" "my_bucket" {
        bucket = "kangane"
        region = "ap-south-1"
}


#target resource we can user to apply specific resource level only below command is the reference 
#terraform apply "-target=aws_s3_bucket.name"
