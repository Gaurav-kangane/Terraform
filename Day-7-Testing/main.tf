module "name" {
    source = "../Day-7-Modules"
    ami_id = var.ami_id
    instance_type = var.instance_type
}