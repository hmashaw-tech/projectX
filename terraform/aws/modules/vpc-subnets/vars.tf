/**
 * Terraform Module - VPC Subnets
 * By: Mark
 */

variable "project-name" {
    type = "string"
    default = "NA"
    description = "Name of project consuming resource"
}

variable "region" {
    type = "string"
    description = "In which AWS region should the VPC be created"
}

variable "vpc-id" {
    type = "string"
    description = "VPC ID"
}

variable "priv1_subnet_addresses" {
  type = "list"
  description = "Subnets for the PRIV1 network"
}

variable "priv2_subnet_addresses" {
  type = "list"
  description = "Subnets for the PRIV2 network"
}

variable "pub_subnet_addresses" {
  type = "list"
  description = "Subnets for the PUB network"
}
