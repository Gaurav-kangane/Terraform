/* In Terraform, the depends_on block is used to explicitly define resource dependencies — 
ensuring one resource is created after another, even if Terraform can’t automatically detect the relationship. */


resource "aws_instance" "public" {
        ami = "ami-01760eea5c574eb86"
        instance_type = "t3.micro"
        tags = {
          Name = "public-ec2"
        }

        depends_on = [ aws_s3_bucket.name ]  #this block is depends on s3 so s3 will create first
}

resource "aws_s3_bucket" "name" {
        bucket = "kangane"
        region = "ap-south-1"
}

