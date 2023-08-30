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

resource "aws_instance" "vault_cli_vm" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public-subnet.id
  key_name      = var.key_name

  vpc_security_group_ids = [aws_vpc.vault-vpc.id]

  associate_public_ip_address = true

  tags = {
    Name = "${var.prefix}-vault-cli-vm"
    Owner = var.owner
  }
}
