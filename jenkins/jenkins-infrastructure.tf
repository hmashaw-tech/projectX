/**
 * Terraform Demo
 * By: Mark
 */

# Create Ubuntu Linux Instance
resource "aws_instance" "jenkins-manager" {
    ami = "${var.ami_id}"
    instance_type = "t2.micro"

    # User Data - CloudInit
    user_data = "${file("jenkinsManager-userData.txt")}"

    # VPC subnet
    subnet_id = "${var.jenkins_subnet}"

    # Security Group
    vpc_security_group_ids = ["${aws_security_group.jenkins-sg.id}"]

    # SSH key
    key_name = "${var.key_name}"

    tags {
        Name = "JenkinsManager"
        Owner = "${var.owner}"
        Project = "${var.project}"
        Terraform = "true"
        Description = "Ubuntu Jenkins Server (Manager) - projextX"
    }
}


resource "aws_instance" "jenkins-worker" {
    ami = "${var.ami_id}"
    instance_type = "t2.micro"

    # User Data - CloudInit
    user_data = "${file("jenkinsWorker-userData.txt")}"

    # VPC subnet
    subnet_id = "${var.jenkins_subnet}"

    # Security Group
    vpc_security_group_ids = ["${aws_security_group.jenkins-sg.id}"]

    # SSH key
    key_name = "${var.key_name}"

    tags {
        Name = "JenkinsWorker"
        Owner = "${var.owner}"
        Project = "${var.project}"
        Terraform = "true"
        Description = "Ubuntu Jenkins Server (Worker) - projextX"
    }
}


# VPC Default Security Group
resource "aws_security_group" "jenkins-sg" {
    vpc_id = "${var.vpc_id}"
    name = "jenkins-sg"
    description = "JenkinsDefault Security Group"

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.aws_ingressIP}"]
    }

    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        self      = true
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${var.aws_ingressIP}"]
    }

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["${var.aws_ingressIP}"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["${var.aws_ingressIP}","${var.gitIPs}"]
    }

    tags {
        Name = "jenkins-sg"
        Owner = "${var.owner}"
        Project   = "${var.project}"
        Terraform = "true"
    }
}
