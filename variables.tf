variable "prefix" {
  description = "This prefix will be included in the name of most resources."
}

variable "region" {
  description = "The region where the resources are created."
  default     = "eu-west-3"
}

variable "azs" {
  description = "The az list where the resources are created."
  default     = [ "eu-west-3a" ]
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

variable "allowed_inbound_cidrs_lb" {
  description = "List of CIDR blocks to permit inbound traffic from to load balancer"
  default = null
}

variable "instance_type" {
  description = "EC2 instance type"
  default = "m5.xlarge"
}
