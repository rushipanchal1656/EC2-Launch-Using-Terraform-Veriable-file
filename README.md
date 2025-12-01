# EC2-Launch-Using-Terraform-Veriable-file

A simple guide to understanding Terraform's variable system when deploying an Amazon Linux EC2 instance.

## 📁 Project Structure

```markdown
terraform-ec2-project/
├── main.tf # EC2 instance configuration
├── variables.tf # Variable definitions
├── terraform.tfvars # Default values (optional)
├── dev.auto.tfvars # Development environment
├── prod.auto.tfvars # Production environment
└── README.md # This file
```

## 🎯 Goal of the Variable file

Deploy an Amazon Linux EC2 instance using different methods to specify the instance type.

## 📝 Variable Declaration (variables.tf)

```bash
# Define what variables our Terraform code accepts
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"  # Fallback value if not specified elsewhere
}

variable "instance_name" {
  description = "Name tag for EC2 instance"
  type        = string
  default     = "my-terraform-instance"
}
```

# 🏗️ Main Configuration (main.tf)

```bash
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Amazon Linux 2 AMI (HVM), SSD Volume Type
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  
  tags = {
    Name = var.instance_name
  }
}

output "instance_id" {
  value = aws_instance.example.id
}
output "instance_public_ip" {
  value = aws_instance.example.public_ip
}
```

# 5 Ways to Set Variables

## Method 1: Default Value (variables.tf)

If you do nothing, instance uses t2.micro from the default value.

## Method 2: terraform.tfvars File

Create terraform.tfvars:

```bash
instance_type = "t2.small"
instance_name = "my-tfvars-instance"
```

Run: terraform apply

## Method 3: *.auto.tfvars Files

Create dev.auto.tfvars:

```bash
instance_type = "t2.medium"
instance_name = "dev-instance"
```

Run: terraform apply (automatically loads this file)

## Method 4: Command Line

```bash
terraform apply -var="instance_type=t2.large" -var="instance_name=cli-instance"
```

## Method 5: Environment Variables

```bash
export TF_VAR_instance_type="t3.micro"
export TF_VAR_instance_name="env-instance"
terraform apply
```

## Method 6: If using environment variables

```bash
terraform destroy -var="instance_type=t2.micro"
```

# 📊 Priority Order

Variables are applied in this order (highest to lowest):

* -var command line flags
* TF_VAR_ environment variables
* *.auto.tfvars files
* terraform.tfvars file
* Default values in variables.tf

# 🧹 Cleanup

```bash
terraform destroy
```

# Created by Rushikesh Panchal
