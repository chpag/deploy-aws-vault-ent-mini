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

locals {
  vault_server_user_data = templatefile(
    "${path.module}/templates/install_vault-ent_server.sh.tpl",
    {
      vault_version           = var.vault_version
      vault_licence_content   = var.vault_licence_content
    }
  )
}

resource "aws_instance" "vault-ent_vm" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = module.vpc.private_subnets[0]
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.vault_sg.id]
  user_data_base64     = base64encode(local.vault_server_user_data)
  tags = {
    Name = "${var.prefix}-vault-ent-vm"
    Owner = var.owner
  }
}
