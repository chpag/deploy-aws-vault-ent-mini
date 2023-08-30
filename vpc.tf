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

resource "aws_route_table" "vault-int-route" {
  vpc_id = aws_vpc.vault-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vault-ig.id
  }
}

resource "aws_route_table_association" "vault-rt-public" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.vault-int-route.id
}

resource "aws_route_table_association" "vault-rt-private" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.vault-int-route.id
}
