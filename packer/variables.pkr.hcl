###########
# Variables
###########
variable "ami_instance_type" {
  description = "The instance type to use for the build"
  type        = string
  default     = "t2.micro"
}

variable "ami_name" {
  description = "The name to apply to the AMI"
  type        = string
  default     = "harness-ami"
}

variable "ami_region" {
  description = "The region to use"
  type        = string
  default     = "ap-southeast-2"
}

variable "ami_script" {
  description = "The provisioner script to use"
  type        = string
  default     = "./setup.sh"
}

variable "ami_script_pause" {
  description = "The time to pause before running the script"
  type        = string
  default     = "10s"
}

variable "ami_script_timeout" {
  description = "The timeout for the script"
  type        = string
  default     = "30s"
}

variable "ami_tags" {
  description = "The tags to apply to the AMI"
  type        = map(string)
  default     = {}
}
