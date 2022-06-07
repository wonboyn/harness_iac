packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}


# AMI source filter
data "amazon-ami" "this" {
  region = var.ami_region
  filters = {
      architecture        = "x86_64",
      name                = "amzn2-ami-hvm-2.0.*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["amazon"]
}


# AMI source definition
source "amazon-ebs" "this" {
  ami_name      = var.ami_name
  instance_type = var.ami_instance_type
  region        = var.ami_region
  ssh_username  = var.ami_ssh_user
  source_ami    = data.amazon-ami.this.id
}


# AMI build definition
build {
  name = "harness-slave-ami"
  sources = [
    "source.amazon-ebs.this"
  ]

  provisioner "shell" {
    script       = var.ami_script
    pause_before = var.ami_script_pause
    timeout      = var.ami_script_timeout
  }

  hcp_packer_registry {
    bucket_name = "harness"
    description = "Harness slave image."
    bucket_labels = {
      "owner"          = "platform-team"
      "os"             = "Amazon Linux",
    }

    build_labels = {
      "build-time"   = timestamp()
      "build-source" = basename(path.cwd)
    }
  }
}
