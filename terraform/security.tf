# Locals
locals {
  nacl_tags = merge(
    var.common_tags, 
    var.nacl_tags
  )
  sg_tags = merge(
    var.common_tags, 
    var.sg_tags
  )
}


# NACL
resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.this.id
  subnet_ids = [aws_subnet.private.id]
  tags       = local.nacl_tags
}

#resource "aws_network_acl" "public" {
#  vpc_id     = aws_vpc.this.id
#  subnet_ids = [aws_subnet.public.id]
#  tags       = local.nacl_tags
#}


# NACL Rules
#resource "aws_network_acl_rule" "public_ssh_in" {
#  network_acl_id = aws_network_acl.public.id
#  rule_number    = 100
#  egress         = false
#  protocol       = "tcp"
#  rule_action    = "allow"
#  cidr_block     = var.nacl_ssh_whitelist_ip
#  from_port      = 22
#  to_port        = 22
#}

#resource "aws_network_acl_rule" "public_harness_in" {
#  network_acl_id = aws_network_acl.public.id
#  rule_number    = 200
#  egress         = false
#  protocol       = "tcp"
#  rule_action    = "allow"
#  cidr_block     = "0.0.0.0/0"
#  from_port      = 9079
#  to_port        = 9079
#}

#resource "aws_network_acl_rule" "public_ephemeral_out" {
#  network_acl_id = aws_network_acl.public.id
#  rule_number    = 300
#  egress         = true
#  protocol       = "tcp"
#  rule_action    = "allow"
#  cidr_block     = var.nacl_ssh_whitelist_ip
#  from_port      = 1024
#  to_port        = 65535
#}


# Security Group
resource "aws_security_group" "this" {
  name_prefix = var.sg_name_prefix
  vpc_id      = aws_vpc.this.id
  tags        = local.sg_tags
}


# Security Group Rule - Allow self
resource "aws_security_group_rule" "ingress_self" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = aws_security_group.this.id
}


# Security Group Rule - allow ssh
resource "aws_security_group_rule" "ingress_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["110.175.70.161/32"]
  security_group_id = aws_security_group.this.id
}


# Security Group Rule - allow 9079 for Harness
resource "aws_security_group_rule" "ingress_harness" {
  type              = "ingress"
  from_port         = 9079
  to_port           = 9079
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}


# Security Group Rule - egress
resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}
