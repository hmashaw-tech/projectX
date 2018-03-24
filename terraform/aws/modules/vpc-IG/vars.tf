/**
 * Terraform Module - Internet Gateway
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

variable "pub-subnet-ids" {
    type = "string"
    description = "Subnet IDs for the PUB network - as delimited : string"
}

variable "name" {
    type = "string"
    description = "Name of the IG (Tag)"
}
