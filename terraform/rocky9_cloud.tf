##############################################
# ☁️ Terraform Stub – Rocky Linux 9 Cloud Portability
# --------------------------------------------------
# This stub represents how the Rocky 9 target VM
# could be reproduced in AWS using Infrastructure as Code.
# It is non-functional and uses placeholder values.
##############################################

terraform {
  required_version = ">= 1.5.0"
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

# Placeholder EC2 instance simulating the Rocky 9 target
resource "aws_instance" "rocky9" {
  ami           = "ami-rocky9-placeholder"  # Replace with real AMI later
  instance_type = "t3.micro"

  tags = {
    Name        = "rocky9-target"
    Environment = "migration-lab"
  }
}

# Output block for demonstration
output "rocky9_instance_id" {
  value       = aws_instance.rocky9.id
  description = "Simulated Rocky 9 cloud instance ID (placeholder)"
}
