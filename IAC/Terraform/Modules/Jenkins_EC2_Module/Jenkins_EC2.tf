
resource "aws_instance" "Jenkins_Ec2" {
     depends_on = [ tls_private_key.my_key ]
  ami           =  data.aws_ami.Amazon_Linux_2.id
  iam_instance_profile = aws_iam_instance_profile.jenkins_ec2_instance_profile.name
  instance_type = var.Ec2_Instance_Type  # Change to your desired instance type
  subnet_id     = var.Public_Subnet1_id
  associate_public_ip_address = true  # Enable public IP

  vpc_security_group_ids = [var.Public_Security_Group_id]

  tags = {
    Name = "Jenkins_instance"
  }
  key_name = aws_key_pair.my_key_pair.key_name
}
output "EC2_Jenkins_id" {
  value = aws_instance.Jenkins_Ec2.id
}
output "Jenkins_public_ip" {
    value = aws_instance.Jenkins_Ec2.public_ip
  
}
output "Jenkins_private_ip" {
    value = aws_instance.Jenkins_Ec2.private_ip
  
}