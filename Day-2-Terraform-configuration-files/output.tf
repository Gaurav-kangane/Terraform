output "private_ip" {
    value = aws_instance.name.private_ip
}

output "availability-zone" {
    value = aws_instance.name.availability_zone
}

output "vpc_id" {
    value = aws_vpc.name.id
  
}

output "instance_arn" {
    value = aws_instance.name.arn
  
}