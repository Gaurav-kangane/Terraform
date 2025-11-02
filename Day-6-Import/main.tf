resource "aws_instance" "name" {
        ami = "ami-01760eea5c574eb86"
        instance_type = "t3.micro"
        tags = {
          Name = "prod"
        }
        
}



/*
terraform import resource.name resource_id
e.g terraform import aws_instance.name i-0337332b9c8940303
If a resource was created manually and you want Terraform to manage it, use the terraform import command. 
It links the existing resource to your Terraform configuration so Terraform can track and manage it going forward.


*/