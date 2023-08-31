Vault Enterprise AWS Module
This is a Terraform module for provisioning Vault Enterprise with integrated storage on AWS. This module defaults to setting up a cluster with 5 Vault nodes (as recommended by the Vault with Integrated Storage Reference Architecture).

About This Module
This module implements the Vault with Integrated Storage Reference Architecture on AWS using the Enterprise version of Vault 1.8+.

How to Use This Module
Ensure your AWS credentials are configured correctly and have permission to use the following AWS services:

Amazon Certificate Manager (ACM)
Amazon EC2
Amazon Elastic Load Balancing (ALB)
AWS Identity & Access Management (IAM)
AWS Key Management System (KMS)
Amazon Simple Storage Service (S3)
Amazon Secrets Manager
AWS Systems Manager Session Manager (optional - used to connect to EC2 instances with session manager using the AWS CLI)
Amazon VPC
This module assumes you have an existing VPC along with an AWS secrets manager that contains TLS certs for the Vault nodes and load balancer. If you do not, you may use the following quickstart to deploy these resources.

To deploy into an existing VPC, ensure the following components exist and are routed to each other correctly:

Three public subnets
Three NAT gateways (one in each public subnet)
Three private subnets
# deploy-aws-vault-ent-mini

variable "prefix" {
  description = "This prefix will be included in the name of most resources."
}

variable "region" {
  description = "The region where the resources are created."
  default     = "eu-west-3"
}

variable "az" {
  description = "The az where the resources are created."
  default     = "eu-west-3a"
}

variable "owner" {
  description = "Owner of the resources"
}

variable "vault_licence_content" {
  description = "Vault Enterprise Licence Content"
}

variable "vault_version" {
  description = "Vault version"
  default     = "1.14.1"
}

variable "key_name" {
  description = "key pair to use for SSH access to instance"
  default = null
}

variable "allowed_inbound_cidrs_ssh" {
  description = "List of CIDR blocks to permit for SSH to Vault nodes"
  default = null
}

variable "private_subnet_cidr" {
  description = "CIDR blocks for private subnet"
  default = "10.0.0.0/19"
}

variable "public_subnet_cidr" {
  description = "CIDR blocks for public subnet"
  default = "10.0.128.0/20"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "allowed_inbound_cidrs_lb" {
  description = "List of CIDR blocks to permit inbound traffic from to load balancer"
  default = null
}

variable "instance_type" {
  description = "EC2 instance type"
  default = "m5.xlarge"
}

variable "tags" {
  type        = map(string)
  description = "Tags for resources"
  default     = {}
}

