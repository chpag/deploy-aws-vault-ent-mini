data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_subnets" "public-subnet" {
  filter {
    name   = "vpc-id"
    values = [module.vpc.vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.prefix}-vault-public-${var.az}"]
  }
}

locals {
  vault_user_data = templatefile(
    var.user_supplied_userdata_path != null ? var.user_supplied_userdata_path : "${path.module}/templates/install_vault.sh.tpl",
    {
      region                  = var.aws_region
      name                    = var.resource_name_prefix
      vault_version           = var.vault_version
      kms_key_arn             = var.kms_key_arn
      s3_bucket_vault_license = var.aws_bucket_vault_license
      vault_license_name      = var.vault_license_name
      secrets_manager_arn     = var.secrets_manager_arn
      leader_tls_servername   = var.leader_tls_servername
    }
  )
}
resource "aws_instance" "vault-ent_vm" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnets.public-subnet.ids[0]
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.vault_sg.id]
  user_data     = var.userdata_script

  tags = {
    Name = "${var.prefix}-vault-ent-vm"
    Owner = var.owner
  }
}
