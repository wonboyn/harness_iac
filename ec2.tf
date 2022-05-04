# Amazon Linux2 AMI ID
data "aws_ami" "amazon-linux-2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  owners = ["amazon"]
}


# EC2 Instance
resource "aws_instance" "this" {
  ami                    = "${data.aws_ami.amazon-linux-2.id}"
  instance_type          = var.ec2_instance_type
  key_name               = var.ec2_key_name
  subnet_id              = aws_subnet.public.id
  user_data_base64       = var.ec2_user_data
  vpc_security_group_ids = [aws_security_group.this.id]
  root_block_device {
    volume_size          = var.ec2_volume_size
  }

  tags = merge(
    var.common_tags, 
    var.ec2_tags
  )
}
