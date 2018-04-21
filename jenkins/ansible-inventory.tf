resource "null_resource" "ansible-inventory1" {
    depends_on = ["aws_instance.jenkins-manager"]

    provisioner "local-exec" {
        command = "echo > ansible-inventory"
    }

    provisioner "local-exec" {
        command = "echo [manager] >> ansible-inventory"
    }

    provisioner "local-exec" {
        command = "echo \"${format("%s ansible_user=%s", aws_instance.jenkins-manager.0.public_ip, var.ssh_user)}\" >> ansible-inventory"
    }
}


resource "null_resource" "ansible-inventory2" {
    depends_on = ["aws_instance.jenkins-worker"]

    provisioner "local-exec" {
        command = "echo >> ansible-inventory"
    }

    provisioner "local-exec" {
        command = "echo [workers] >> ansible-inventory"
    }

    provisioner "local-exec" {
        command = "echo \"${format("%s ansible_user=%s", aws_instance.jenkins-worker.0.public_ip, var.ssh_user)}\" >> ansible-inventory"
    }
}
