resource "tls_private_key" "my_key" { 
algorithm = "RSA" 
rsa_bits = 2048 
}
resource "local_file" "private_key" {
  filename = "${path.module}/../../../../Project_Keys/osama.pem"
  content  = tls_private_key.my_key.private_key_pem
}

resource "local_file" "public_key" {
  filename = "${path.module}/../../../../Project_Keys/osama.pub"
  content  = tls_private_key.my_key.public_key_openssh
}


resource "aws_key_pair" "my_key_pair" { 
    key_name = "osama" # Desired key name 
     public_key = local_file.public_key.content
     depends_on = [ tls_private_key.my_key ]
}
output "my_key" {
  value = aws_key_pair.my_key_pair.key_name
}

resource "null_resource" "Change_key_permission" {
  depends_on = [ tls_private_key.my_key ]
  provisioner "local-exec" {
    command = "echo '2510' | sudo -S chmod 400 /home/mosama/Project_Keys/osama.pem"
  }  
 }