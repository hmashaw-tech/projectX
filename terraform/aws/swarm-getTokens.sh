export TF_VAR_swarm_manager_token=$(ssh -i ../../keys/projectX.key ubuntu@$(terraform output swarm_manager_1_public_ip) docker swarm join-token -q manager)

export TF_VAR_swarm_worker_token=$(ssh -i ../../keys/projectX.key ubuntu@$(terraform output swarm_manager_1_public_ip) docker swarm join-token -q worker)

export TF_VAR_swarm_manager_ip=$(terraform output swarm_manager_1_private_ip)
