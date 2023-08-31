# Vault Enterprise AWS Mini Deployments
This is a Terraform Code for provisioning a mini Vault Enterprise (1 node) with integrated storage on AWS. 

The Vault Server is only accessible in a private subnet with  TLS disabled
(You should provide a certificate  and change some configuration settings if you want to activate TLS)

A second Server with public-ip is started and preconfigured to access vault

# how to use it
 Run `terraform init` and `terraform apply`

  - You must
    [initialize](https://www.vaultproject.io/docs/commands/operator/init#operator-init)
    your Vault cluster after you create it. Begin by logging into your Vault
    cluster using one of the following methods:
      - Using [Session
        Manager](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/session-manager.html)
      - SSH (you must provide the optional SSH key pair through the `key_name`
        variable and set a value for the `allowed_inbound_cidrs_ssh` variable.
          - Please note the Vault cluster is not public-facing. If you want to
            use SSH from outside the VPC, you are required to establish to use the Vault Cli VM.
  
  - To connect to the Vault Cli VM.
```bash
ssh -i "{$var_keyname}" ubuntu@${vault-cli-vm}
```

 - Verify the connectiviry with Vault Server.
```bash
vault status

```
   This should presented the following status:
   Initialized        false
   Sealed             true

 - To initialize the Vault cluster, run the following commands:

```bash
vault operator init
```

  - This should return back the following output which includes the Unseal
    keys and initial root token (omitted here):

```
...
Success! Vault is initialized
```

  - Please securely store the recovery keys and initial root token that Vault
    returns to you.

 - To Unseal the Vault cluster, run the following commands ( 3 times) and provide 3 different unsel keys:

```bash
vault operator unseal
```
- To Verify the Vault cluster, run the following commands :

```bash
vault status
```
   This should presented the following status:
   Initialized        true
   Sealed             false

- To Login to the Vault cluster, run the following commands and provide the Initial Root Token:

```bash
vault login
```

# deploy-aws-vault-ent-mini
Here are the variables availables

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
  description = "Vault Enterprise Licence Content" (Should be defined as Sensible)
}

variable "vault_version" {
  description = "Vault version"
  default     = "1.14.1"
}

variable "key_name" {
  description = "key pair to use for SSH access to instance"
}

variable "allowed_inbound_cidrs_ssh" {
  description = "List of CIDR blocks to permit for SSH to Vault nodes" (Should be defined as HCL variables)
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

variable "instance_type" {
  description = "EC2 instance type"
  default = "m5.xlarge"
}

variable "tags" {
  type        = map(string)
  description = "Tags for resources"
  default     = {}
}

## License

This code is released under the Mozilla Public License 2.0. Please see
[LICENSE](https://github.com/hashicorp/terraform-aws-vault-ent-starter/blob/main/LICENSE)
for more details.
