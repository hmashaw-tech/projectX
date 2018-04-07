/**
 * Terraform Module - VPC
 * By: Mark
 */

output "vpc-id" {
    value = "${aws_vpc.vpc.id}"
}
