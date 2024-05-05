resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  tags       = var.tags
}

resource "aws_subnet" "public_subnets" {
  for_each          = var.public_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags              = var.tags
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.tags
}

resource "aws_route_table" "public_rt" {
  for_each = var.public_subnets
  vpc_id   = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_eip" "eip" {
  for_each = var.public_subnets
  tags     = var.tags
}

resource "aws_nat_gateway" "ngw" {
  for_each      = aws_subnet.public_subnets
  allocation_id = aws_eip.eip[each.key].id
  subnet_id     = each.value.id
  tags          = var.tags
}

resource "aws_route_table_association" "public_rt_association" {
  for_each       = var.public_subnets
  subnet_id      = aws_subnet.public_subnets[each.key].id
  route_table_id = aws_route_table.public_rt[each.key].id
}

resource "aws_subnet" "private_subnets" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags              = var.tags
}


resource "aws_route_table" "private_rt" {
  for_each = aws_nat_gateway.ngw
  vpc_id   = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = each.value.id
  }
}

resource "aws_route_table_association" "private_rt_association" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = values(aws_subnet.private_subnets)[count.index].id
  route_table_id = values(aws_route_table.private_rt)[count.index].id
}


