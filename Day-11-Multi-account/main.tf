resource "aws_s3_bucket" "name" {
        bucket = "kangane"
        
}

resource "aws_instance" "name" {
        ami = "ami-0305d3d91b9f22e84"
        instance_type = "t3.micro"
        provider = aws.N_virginia
}