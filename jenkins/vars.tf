/**
 * Terraform Demo
 * By: Mark
 */

# Ubuntu Server 16.04 LTS (HVM) 17APR2018
variable "ami_id" {}

variable "aws_ingressIP" {}

variable "key_name" { default = "projectX" }

variable "owner" { default = "projectX" }

variable "project" { default = "projectX" }

# Default VPC - us-west-2a
variable "jenkins_subnet" { default = "subnet-14d2235f" }

variable "ssh_user" { default = "ubuntu" }

# Default VPC - us-west-2
variable "vpc_id" { default = "vpc-e430569d" }

variable "gitIPs" {
    type = "list"
    default = ["192.30.252.0/22",
               "185.199.108.0/22",
               "13.229.188.59/32",
               "13.250.177.223/32",
               "18.194.104.89/32",
               "18.195.85.27/32",
               "35.159.8.160/32",
               "52.74.223.119/32"]
}

