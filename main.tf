provider "aws" {
  region = "ap-south-1"
}

/*
#Project 1: Create an EC2 instance using variables

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



#Project 2: Use heredoc to create a user data script that installs Apache web server on the EC2 instance
resource "aws_instance" "apache-server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids
  user_data              = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Welcome to the Apache Web Server</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "Apache_Server_Instance"
  }
}


# Practical 3: Use of Data block to fetch existing security group details
resource "aws_instance" "web-server" {
  ami                = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  vpc_security_group_ids = [data.aws_security_group.aws-sg.id]

    tags = {
        Name = "WebServerInstance"
    }
}

data "aws_security_group" "aws-sg" {
 name = "launch-wizard-1"
 vpc_id = "vpc-0b75c5e0c5987f55b"
}

*/ 

# Practical 4: Use terraform import to bring an existing resources into management
resource "aws_instance" "web-server" {
  ami                = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  vpc_security_group_ids = [aws_security_group.aws-sg.id]

    tags = {
        Name = "WebServerInstance"
    }
}

resource "aws_security_group" "aws-sg" {
 name = "launch-wizard-1"
 vpc_id = "vpc-0b75c5e0c5987f55b"

}