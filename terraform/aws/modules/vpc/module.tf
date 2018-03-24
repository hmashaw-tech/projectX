/**
 * Terraform Module - VPC
 * By: Mark
 */

provider "aws" {
      region = "${var.region}"
}


# Create VPC
resource "aws_vpc" "vpc" {
    cidr_block = "${var.network-address}"

    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags {
        Name      = "${var.name}"
        Project   = "${var.project-name}"
        Terraform = "true"
    }
}
