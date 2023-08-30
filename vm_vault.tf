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

resource "aws_instance" "vault-ent_vm" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnets.public-subnet.ids[0]
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.vault_sg.id]

  tags = {
    Name = "${var.prefix}-vault-ent-vm"
    Owner = var.owner
  }
}
