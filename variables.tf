##########
# Common
##########
variable "common_tags" {
  description = "The tags to apply to any resource"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "The region to use"
  type        = string
  default     = "ap-southeast-2"
}


##########
# EC2 
##########
variable "ec2_instance_type" {
  description = "The EC2 instance type to use"
  type        = string
  default     = "t2.micro"
}

variable "ec2_key_name" {
  description = "Name of the EC2 keypair to use"
  type        = string
  default     = "harness"
}

variable "ec2_user_data" {
  description = "The base64 encoded user data to pass to the EC2 instance"
  type        = string
  default     = ""
}

variable "ec2_volume_size" {
  description = "The EC2 root volume size to use"
  type        = number
  default     = 30
}

variable "ec2_tags" {
  description = "The tags to apply to the EC2 instance"
  type        = map(string)
  default     = {}
}


##########
# NACL's
##########
variable "nacl_tags" {
  description = "The tags to apply to the Network ACL's"
  type        = map(string)
  default     = {}
}


##########
# NACL Rules
##########
variable "nacl_ssh_whitelist_ip" {
  description = "The CIDR block to whitelist for SSH"
  type        = string
  default     = ""
}


##########
# SG's
##########
variable "sg_name_prefix" {
  description = "The name prefix to use for the security group"
  type        = string
  default     = "harness"
}

variable "sg_tags" {
  description = "The tags to apply to the security group"
  type        = map(string)
  default     = {}
}


##########
# Subnets
##########
variable "subnet_cidr_block_private" {
  description = "The CIDR block to use for the private subnet"
  type        = string
  default     = "10.0.100.0/24"
}

variable "subnet_cidr_block_public" {
  description = "The CIDR block to use for the public subnet"
  type        = string
  default     = "10.0.200.0/24"
}

variable "subnet_tags" {
  description = "The tags to apply to the subnets"
  type        = map(string)
  default     = {}
}


##########
# VPC 
##########
variable "vpc_cidr_block" {
  description = "The CIDR block to use for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_tags" {
  description = "The tags to apply to the VPC"
  type        = map(string)
  default     = {}
}
