resource "aws_instance" "swarm-manager" {
    count = "${var.swarm_managers}"
    ami = "${var.swarm_ami_id}"
    instance_type = "${var.swarm_instance_type}"
    
    # VPC subnet
    subnet_id = "${element(split(":", module.vpc-subnets.pub-subnet-ids), 0)}"

    # Security Group
    vpc_security_group_ids = ["${aws_security_group.projectX-sg.id}"]

    # Public SSH key
    key_name = "projectX"

    # How to connect for provisioning
    connection {
        user = "ubuntu"
        private_key = "${file("./keys/projectX.key")}"
    }

    # Run on remote resource after it is created
    provisioner "remote-exec" {
        inline = [
        "if ${var.swarm_init}; then docker swarm init --advertise-addr ${self.private_ip}; fi",
        "if ! ${var.swarm_init}; then docker swarm join --token ${var.swarm_manager_token} --advertise-addr ${self.private_ip} ${var.swarm_manager_ip}:2377; fi"
        ]
    }

    tags {
        Name = "swarm-manager"
        Project = "${var.project-name}"
        Terraform = "true"
    }
}


resource "aws_instance" "swarm-worker" {
    count = "${var.swarm_workers}"
    ami = "${var.swarm_ami_id}"
    instance_type = "${var.swarm_instance_type}"

    # VPC subnet
    # Think this is cool because it spreads the workers across the subnets :)
    subnet_id = "${element(split(":", module.vpc-subnets.pub-subnet-ids), count.index)}"

    # Security Group
    vpc_security_group_ids = ["${aws_security_group.projectX-sg.id}"]

    # Public SSH key
    key_name = "projectX"

    # How to connect for provisioning
    connection {
        user = "ubuntu"
        private_key = "${file("./keys/projectX.key")}"
    }

    # Run on remote resource after it is created
    provisioner "remote-exec" {
        inline = [
        "echo \"docker swarm join --token ${var.swarm_worker_token} --advertise-addr ${self.private_ip} ${var.swarm_manager_ip}:2377\"",
        "docker swarm join --token ${var.swarm_worker_token} --advertise-addr ${self.private_ip} ${var.swarm_manager_ip}:2377"
        ]
    }

    tags {
        Name = "swarm-worker"
        Project = "${var.project-name}"
        Terraform = "true"
    }
}
