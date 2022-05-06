# Locals
locals {
  az   = "${var.region}a"
  tags = merge(
    var.common_tags, 
    var.vpc_tags
  )
}


# Internet Gateway
resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id
    tags   = local.tags
}


# Route Tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = local.tags
}


# Route Tables Association
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}


# Subnets
resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.subnet_cidr_block_private
  map_public_ip_on_launch = false
  availability_zone       = local.az
  tags                    = local.tags
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.subnet_cidr_block_public
  map_public_ip_on_launch = true
  availability_zone       = local.az
  tags                    = local.tags
}


# VPC for the Harness Delegate
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block
  tags       = local.tags
}
