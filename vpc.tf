resource "aws_vpc" "vault-vpc" {
  cidr_block = var.vpc_cidr

}

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.vault-vpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = var.az

  tags = {
    Name = "${var.prefix}-vault-public-${var.az}"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.vault-vpc.id
  cidr_block = var.private_subnet_cidr 
  availability_zone = var.az

  tags = {
    Name = "${var.prefix}-vault-private-${var.az}"
  }
}

resource "aws_internet_gateway" "vault-ig" {
  vpc_id = aws_vpc.vault-vpc.id

  tags = {
    Name = "${var.prefix}-internet-gateway"
  }
}
