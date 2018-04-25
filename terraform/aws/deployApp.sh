#

ssh -i ../../keys/projectX.key ubuntu@$(terraform output swarm_manager_1_public_ip) "\
    docker stack rm projectDemo && \
    sleep 5 && \
    rm -rf projectX && \
    git clone https://github.com/hmashaw-tech/projectX.git && \
    cd projectX && \
    docker stack deploy -c docker-compose-projectX.yml projectDemo \
    "
