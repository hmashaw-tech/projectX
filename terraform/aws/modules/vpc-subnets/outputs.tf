/**
 * Terraform Module - VPC Subnets
 * By: Mark
 */

output "pub-subnet-ids" {
    value = "${ join(":", aws_subnet.Pub.*.id) }"
}

output "priv1-subnet-ids" {
    value = "${ join(":", aws_subnet.Priv1.*.id) }"
}

output "priv2-subnet-ids" {
    value = "${ join(":", aws_subnet.Priv2.*.id) }"
}

output "pub_subnet_addresses" {
    value = "${var.pub_subnet_addresses}"
}

output "priv1_subnet_addresses" {
    value = "${var.priv1_subnet_addresses}"
}

output "priv2_subnet_addresses" {
    value = "${var.priv2_subnet_addresses}"
}
