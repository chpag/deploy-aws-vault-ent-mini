
resource "aws_instance" "vault_cli_vm" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnets.public-subnet.ids[0]
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.vault_sg.id]

  associate_public_ip_address = true

  tags = {
    Name = "${var.prefix}-vault-cli-vm"
    Owner = var.owner
  }
}
