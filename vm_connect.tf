locals {
  vault_bin_user_data = templatefile(
    "${path.module}/templates/install_vault-ent_bin.sh.tpl",
    {
      vault_version    = var.vault_version
      vault_server     = aws_instance.vault-ent_vm.private_dns
    }
  )
}

resource "aws_instance" "vault-cli_vm" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnets[0]
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.vault_sg.id]

  associate_public_ip_address = true
  user_data_base64 = base64encode(vault_bin_user_data)

  tags = {
    Name = "${var.prefix}-vault-cli-vm"
    Owner = var.owner
  }
}
