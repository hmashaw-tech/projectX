#

#if [[ -z $2 ]]; then
#    echo "buildIt.sh takes exactly two args: <ingressIP> <swarm_ami_id>"
#    return 1
#fi

clear
echo "Welcome to the Swarm Cluster build script"
read -p "Would you like to build a new AMI via Packer? (only yes will proceed) > " yn

if [[ $yn == 'yes' ]]; then
    cd ../../packer
    . ./packer-build.sh
    cd $OLDPWD
fi

echo
echo "Retrieving Ingress IP..."
INGRESS_IP=$(curl --silent http://checkip.amazonaws.com)

echo "Retrieving AMI ID..."
AMI_ID=$(aws ec2 describe-images \
    --owners self \
    --filters "Name=name,Values=ProjectX-Ubuntu-Docker" \
    | grep ami | cut -f2 -d: | sed -e 's/\"//g; s/,//; s/\ //g')

echo
echo "Building Docker Swarm with ingressIP [$INGRESS_IP] and ami ID: [$AMI_ID]"
read -p "Do you wish to continue? (only yes will proceed) > " yn

if [[ $yn == 'yes' ]]; then
    echo
    echo "Building Swarm ..."

    echo "Setting Ingress IP -> $INGRESS_IP ..."
    export TF_VAR_vpc_ingressIP=$INGRESS_IP

    echo "Setting AMI ID -> $AMI_ID ..."
    export TF_VAR_swarm_ami_id=$AMI_ID

    echo "Setting ANSIBLE_HOST_KEY_CHECKING=False"
    export ANSIBLE_HOST_KEY_CHECKING=False

    echo
    echo "Running Swarm Init ..."
    . ./swarm-init.sh

    echo
    echo "Getting Swarm Tokens ..."
    . ./swarm-getTokens.sh

    echo
    echo "Continuing Swarm build ..."
    terraform apply
else
    echo
    echo "Okay, terminating build."
    echo
    return 0
fi

echo
echo "Configuring for InSpec..."
. ./build-inspec.sh
echo

echo
echo "Running Ansible Playbook..."
cd ../../ansible
. ./ansible-run-playbook.sh
cd $OLDPWD

export swarm_manager_1_public_ip=$(terraform output swarm_manager_1_public_ip)

echo "Swarm build is complete."
echo
ssh -i ../../keys/projectX.key ubuntu@$(terraform output swarm_manager_1_public_ip) docker node ls

echo
echo "To connect to the swarm manager run 'ssh -i ../../keys/projectX.key ubuntu@$swarm_manager_1_public_ip'"
echo

read -p "Would you like to deploy the Default Service Stack? (only yes will proceed) > " yn

if [[ $yn == 'yes' ]]; then
    echo
    echo "Deploying 'Default Service Stack' ..."
    echo

    . ./deployApp.sh

    echo
    echo "buildIt.sh is complete."
    echo
    echo "The Visualizer service can be reached at http://$swarm_manager_1_public_ip:7000"
    echo "The Explore California service can be reached at http://$swarm_manager_1_public_ip:8000"
    echo "The Ninja App API can be reached at http://$swarm_manager_1_public_ip:9000/api"
    echo

else
    echo
    echo "buildIt.sh is complete."
    echo
fi

