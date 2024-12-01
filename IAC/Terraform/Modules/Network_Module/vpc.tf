resource "aws_vpc" "my-vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "my-vpc"
    }
  
}