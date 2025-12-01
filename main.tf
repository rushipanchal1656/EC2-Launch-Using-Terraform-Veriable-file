provider "aws" {
  region = "ap-south-1"
}
#USE VAEIABLES WHICH ARE DEFINED IN variables.tf FILE
resource "aws_instance" "web-server" {
  ami                = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  vpc_security_group_ids = var.security_group_ids

    tags = {
        Name = "WebServerInstance"
    }
}


#Heredoc for user data script
