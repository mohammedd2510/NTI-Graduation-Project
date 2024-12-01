variable "Public_Security_Group_id" {
    type = string
}
variable "Public_Subnet1_id" {
    type = string
}

variable "Ec2_Instance_Type" {
    type = string
    default = "t2.small"
}
