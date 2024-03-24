packer {
  required_plugins {
    digitalocean = {
      version = ">= 1.0.4"
      source  = "github.com/digitalocean/digitalocean"
    }
  }
}

variable "api_token" {
  type    = string
  default = "${env("DIGITALOCEAN_TOKEN")}"
}
variable "do_image" {
  type    = string
  default = "ubuntu-22-04-x64"
}
variable "do_size" {
  type    = string
  default = "s-1vcpu-1gb"
}
variable "snapshot_name" {
  type    = string
  default = "${env("AMI_NAME")}"
}
variable "dockerhub_login" {
  type    = string
  default = "${env("DOCKERHUB_LOGIN")}"
}

variable "dockerhub_password" {
  type    = string
  default = "${env("DOCKERHUB_PASSWORD")}"
}

variable "helper_script_folder" {
  type    = string
  default = "/imagegeneration/helpers"
}

variable "imagedata_file" {
  type    = string
  default = "/imagegeneration/imagedata.json"
}

variable "image_folder" {
  type    = string
  default = "/imagegeneration"
}

variable "image_os" {
  type = string
  // ex: ubuntu22
  default = "${env("IMAGE_OS")}"
}

variable "image_version" {
  type    = string
  default = "${env("IMAGE_VERSION")}"
}

variable "installer_script_folder" {
  type    = string
  default = "/imagegeneration/installers"
}

variable "region" {
  type    = string
  default = "nyc3"
}

// make sure the subnet auto-assigns public IPs
variable "subnet_id" {
  type    = string
  default = "${env("SUBNET_ID")}"
}

variable "volume_size" {
  type    = number
  default = 40
}

variable "volume_type" {
  type    = string
  default = "gp3"
}

source "digitalocean" "build_ebs" {
  api_token               = "${var.api_token}"
  image                   = "${var.do_image}"
  region                  = "${var.region}"
  size                    = "${var.do_size}"
  ssh_username            = "root"
  snapshot_name           = "${var.snapshot_name}"
  connect_with_private_ip = "false"
  tags = ["JonnyShuali"]
  snapshot_regions = [
    "nyc1",
    // "nyc2",
    "nyc3",
    // "ams2",
    "ams3",
    // "sfo1",
    "sfo2",
    "sfo3",
    "sgp1",
    "lon1",
    "fra1",
    "tor1",
    "blr1",
    "syd1"
  ]
}
