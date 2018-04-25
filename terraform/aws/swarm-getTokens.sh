swarm_manager_public_ip=$(terraform output swarm_manager_1_public_ip)

# Automation Demo - Review with InfoSec
# ssh-keyscan $swarm_manager_public_ip
ssh -o StrictHostKeyChecking=no ubuntu@$swarm_manager_public_ip

export TF_VAR_swarm_manager_token=$(ssh -i ../../keys/projectX.key ubuntu@$swarm_manager_public_ip docker swarm join-token -q manager)

export TF_VAR_swarm_worker_token=$(ssh -i ../../keys/projectX.key ubuntu@$swarm_manager_public_ip docker swarm join-token -q worker)

export TF_VAR_swarm_manager_ip=$(terraform output swarm_manager_1_private_ip)
