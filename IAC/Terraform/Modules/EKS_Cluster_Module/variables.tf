variable "Public_Subnet1_id" {
    type = string
  
}
variable "Public_Subnet2_id" {
    type = string
  
}
variable "my_key" {
  type = string
}
variable "security_group_id" {
 type = string  
}
variable "eks_worker_ami_id" {
  type = string
  default = "ami-094fb6db0f574f0d6"
}