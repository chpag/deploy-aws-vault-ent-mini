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

variable "s3_bucket_vault_license" {
  description = "S3 bucket ID containing Vault license"
}

variable "vault_licence_name" {
  description = "Name of Vault license file"
}


