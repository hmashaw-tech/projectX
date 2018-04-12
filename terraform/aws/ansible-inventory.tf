resource "null_resource" "ansible-inventory" {
    depends_on = ["aws_instance.swarm-manager", "aws_instance.swarm-worker"]

    provisioner "local-exec" {
        command = "echo > ../../ansible/ansible-inventory"
    }

    provisioner "local-exec" {
        command = "echo [swarm-manager] >> ../../ansible/ansible-inventory"
    }

    provisioner "local-exec" {
        command = "echo \"${format("%s ansible_user=%s", aws_instance.swarm-manager.0.public_ip, var.ssh_user)}\" >> ../../ansible/ansible-inventory"
    }

    provisioner "local-exec" {
        command = "echo >> ../../ansible/ansible-inventory"
    }

    provisioner "local-exec" {
        command = "echo [swarm-managers] >> ../../ansible/ansible-inventory"
    }

    provisioner "local-exec" {
        command = "echo \"${join("\n",formatlist("%s ansible_user=%s", aws_instance.swarm-manager.*.public_ip, var.ssh_user))}\" >> ../../ansible/ansible-inventory"
    }

    provisioner "local-exec" {
        command = "echo >> ../../ansible/ansible-inventory"
    }

    provisioner "local-exec" {
        command = "echo [swarm-workers] >> ../../ansible/ansible-inventory"
    }
    
    provisioner "local-exec" {
        command = "echo \"${join("\n",formatlist("%s ansible_user=%s", aws_instance.swarm-worker.*.public_ip, var.ssh_user))}\" >> ../../ansible/ansible-inventory"
    }
}
