resource "aws_instance" "name" {
        ami="ami-01760eea5c574eb86"
        instance_type = "t3.micro"
        tags = {
          Name = "dev"
        }


        #lifecycle rule 
        /*The default action of terraform is first destroy and then create resourses, in below code if change we change
         instance type the resource will create first and then it will destroy old resource */
        
       /* lifecycle {
        create_before_destroy = true
        } */

        
        
        /*lifecycle ignore_changes tells Terraform to ignore updates made outside Terraform for specific attributes.
        Example: if someone changes the EC2 instance name in AWS, 
        Terraform won’t try to revert it during the next apply.  */
        /*lifecycle {
          ignore_changes = [ tags, ]
        } */


        /* prevent_destroy ensures Terraform 
        won’t delete a resource, even if it’s removed from the configuration or targeted for destruction.  */
        /*lifecycle {
          prevent_destroy = true
        }  */
}