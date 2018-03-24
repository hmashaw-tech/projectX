/**
 * Terraform Module - VPC
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

variable "name" {
    type = "string"
    description = "Name of the VPC (Tag)"
}

variable "network-address" {
    type = "string"
    description = "VPC Network Address"
}
