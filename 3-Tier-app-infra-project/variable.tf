variable "rds-password" {
        description = "rds-password"
        type = string
        default = "Cloud123"
}

variable "rds-username" {
        description = "rds-username"
        type = string
        default = "admin"
}

variable "ami" {
        type = string
        default = "ami-0305d3d91b9f22e84"
}

variable "instance_type" {
        type = string
        default = "t3.micro"
}   

variable "key_name" {
        type = string
        default = "custkey"
}

