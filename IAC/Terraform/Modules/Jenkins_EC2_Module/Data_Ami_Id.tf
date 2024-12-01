data "aws_ami" "Amazon_Linux_2" {

 most_recent = true  # Ensure you get the most recent AMI
  owners      = ["amazon"]  # Only consider AMIs owned by Amazon
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]  # Filter for Amazon Linux 2 AMIs
  }
}