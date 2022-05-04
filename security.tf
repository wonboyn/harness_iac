# Security Group
resource "aws_security_group" "this" {
  name_prefix = var.sg_name_prefix
  vpc_id      = aws_vpc.this.id

  tags = merge(
    var.common_tags, 
    var.sg_tags
  )
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


# Security Group Rule - allow https
resource "aws_security_group_rule" "ingress_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
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
