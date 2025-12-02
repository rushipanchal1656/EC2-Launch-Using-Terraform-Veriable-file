variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  default     = "ami-0d176f79571d18a8f" #Assignment of ID 
}

variable "instance_type" {
  description = "The type of instance to use"
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the key pair to use for the instance"
  default     = "Mumbai_server_key"
}

variable "security_group_ids" {
  description = "The security group IDs to associate with the instance"
  type        = list(string)
  default     = ["sg-097b1ef2b0fd5d6be"]
}

