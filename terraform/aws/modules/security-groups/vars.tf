/**
 * Terraform Module - Security Groups
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

variable "vpc-ingressIP" {
    type = "string"
    description = "Default Source IP for ingress to VPC"
}

variable "pub_subnet_addresses" {
    type = "list"
    description = "Public Subnets"
}
