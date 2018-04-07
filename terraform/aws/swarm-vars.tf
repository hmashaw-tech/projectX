variable ssh_user { default = "ubuntu" }

variable swarm_manager_token { default = "" }
variable swarm_worker_token { default = "" }

variable swarm_ami_id { default = "unknown" }

variable swarm_manager_ip { default = "" }

variable swarm_managers { default = 2 }
variable swarm_workers { default = 2 }

variable swarm_instance_type { default = "t2.micro" }

variable swarm_init { default = false }

variable "gitIPs" {
    type = "list"
    default = ["192.30.252.0/22",
               "185.199.108.0/22",
               "13.229.188.59/32",
               "13.250.177.223/32",
               "18.194.104.89/32",
               "18.195.85.27/32",
               "35.159.8.160/32",
               "52.74.223.119/32"]
}
