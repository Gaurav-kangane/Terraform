variable "ami" {
    description = "I am creating ami"
    default = ""
    type = string
  
}

variable "instance_type" {
    description = "I am giving instance type for instance"
    default = ""
    type = string
}

variable "availability_zone" {
    description = "Availability zone for subnet"
    default = ""
    type = string
}