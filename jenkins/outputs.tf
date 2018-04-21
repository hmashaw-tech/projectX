
output "jenkins_manager_public_ip" {
  value = "${aws_instance.jenkins-manager.0.public_ip}"
}

