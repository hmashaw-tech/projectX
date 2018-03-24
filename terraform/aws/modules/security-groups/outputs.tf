/**
 * Terraform Module - Security Groups
 * By: Mark
 */

output "SG-Public-Default-Win-id" {
    value = "${aws_security_group.SG-Public-Default-Win.id}"
}

output "SG-Public-Default-Linux-id" {
    value = "${aws_security_group.SG-Public-Default-Linux.id}"
}

output "SG-PublicToPrivate-id" {
    value = "${aws_security_group.SG-PublicToPrivate.id}"
}
