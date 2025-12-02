
#Compulsary arrgument --> Bucker, Region, Key
 terraform {
   backend "s3" {
     bucket = "statefile-remote-backend-storage-123"
     key = "terraform.tfstate"
     region = "ap-south-1"
   }
 }


provider "aws" {
  region = "ap-south-1"
}


resource "aws_instance" "web-server" {
  ami                = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  vpc_security_group_ids = var.security_group_ids

    tags = {
        Name = "WebServerInstance"
    }
}