/**
 * Terraform Module - VPC Subnets
 * By: Mark
 */

provider "aws" {
      region = "${var.region}"
}

# Query AWS data source for list of available AZs
data "aws_availability_zones" "available-azs" {}


# Create Subnets utilizing priv1_subnet_addresses list
resource "aws_subnet" "Priv1" {
    vpc_id = "${var.vpc-id}"
    count = "${length(var.priv1_subnet_addresses)}"
    cidr_block = "${element(var.priv1_subnet_addresses, count.index)}"
    availability_zone = "${element(data.aws_availability_zones.available-azs.names, count.index)}"
    map_public_ip_on_launch = false

    tags {
        Name = "${var.project-name}-Priv1-${count.index}"
        Project = "${var.project-name}"
        Terraform = "true"
    }
}


# Create Subnets utilizing priv2_subnet_addresses list
resource "aws_subnet" "Priv2" {
    vpc_id = "${var.vpc-id}"
    count = "${length(var.priv2_subnet_addresses)}"
    cidr_block = "${element(var.priv2_subnet_addresses, count.index)}"
    availability_zone = "${element(data.aws_availability_zones.available-azs.names, count.index)}"
    map_public_ip_on_launch = false

    tags {
        Name = "${var.project-name}-Priv2-${count.index}"
        Project = "${var.project-name}"
        Terraform = "true"
    }
}


# Create Subnets utilizing pub_subnet_addresses list
resource "aws_subnet" "Pub" {
    vpc_id = "${var.vpc-id}"
    count = "${length(var.pub_subnet_addresses)}"
    cidr_block = "${element(var.pub_subnet_addresses, count.index)}"
    availability_zone = "${element(data.aws_availability_zones.available-azs.names, count.index)}"
    map_public_ip_on_launch = true

    tags {
        Name = "${var.project-name}-Pub-${count.index}"
        Project = "${var.project-name}"
        Terraform = "true"
    }
}
