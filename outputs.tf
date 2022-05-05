# Outputs for convenience
output "ec2_id" {
  value        = aws_instance.this.id
  description  = "ID of ec2 instance"
}

output "ec2_ip_address" {
  value        = aws_instance.this.public_ip
  description  = "Public IP address of ec2 instance"
}
