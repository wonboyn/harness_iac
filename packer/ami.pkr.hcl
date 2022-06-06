packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}


# AMI source definition
source "amazon-ebs" "this" {
  ami_name      = var.ami_name
  instance_type = var.ami_instance_type
  region        = var.ami_region

  source_ami_filter {
    filters = {
      architecture        = "x86_64",
      name                = "amzn2-ami-hvm-2.0.*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "ec2-user"
}


# AMI build definition
build {
  name = "harness-slave"
  sources = [
    "source.amazon-ebs.this"
  ]

  provisioner "shell" {
    script       = var.ami_script
    pause_before = var.ami_script_pause
    timeout      = var.ami_script_timeout
  }
}
