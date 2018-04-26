#!/bin/bash

clear

_packerBuild() {
    cd ../../packer
    . ./packer-build.sh
    cd $OLDPWD
}


_getAMIid() {
    AMI_ID=$(aws ec2 describe-images \
    --owners self \
    --filters "Name=name,Values=ProjectX-Ubuntu-Docker" \
    | grep ami | cut -f2 -d: | sed -e 's/\"//g; s/,//; s/\ //g')
}


_ansiblePlaybook() {
    cd ../../ansible
    . ./ansible-run-playbook.sh
    cd $OLDPWD
}


_defaultServiceStack() {
    echo
    echo -e "Deploying 'Default Service Stack' ...\n"

    . ./deployApp.sh

    echo
    echo "buildIt.sh is complete."
    echo
    echo "The Visualizer service can be reached at http://$swarm_manager_1_public_ip:7000"
    echo "The Explore California service can be reached at http://$swarm_manager_1_public_ip:8000"
    echo "The Node Demo App service can be reached at http://$swarm_manager_1_public_ip:8500/api"
    echo "The Ninja App API can be reached at http://$swarm_manager_1_public_ip:9000/api"
    echo
}


# Setting OPTIND since we are 'sourcing' script
OPTIND=1
INTERACTIVE="true"

while getopts ":q" ARGS
do
    case $ARGS in

        q)
            INTERACTIVE="false"
            ;;

        \?)
            echo -e "Usage: . ./buildIt.sh [-q]\n"
            return 1
            ;;

    esac
done


echo -e "Welcome to the Swarm Cluster build script\n"

echo "Retrieving Ingress IP ..."
INGRESS_IP=$(curl --silent http://checkip.amazonaws.com)

echo "Retrieving AMI ID ..."
_getAMIid
echo


echo "Setting Swarm Region -> $AWS_DEFAULT_REGION ..."
export TF_VAR_vpc_region=$AWS_DEFAULT_REGION

echo "Setting Ingress IP -> **redacted** ..."
export TF_VAR_vpc_ingressIP=$INGRESS_IP

echo "Setting AMI ID -> $AMI_ID ..."
export TF_VAR_swarm_ami_id=$AMI_ID

echo "Setting TF_IN_AUTOMATION=true ..."
export TF_IN_AUTOMATION=true

echo "Setting ANSIBLE_HOST_KEY_CHECKING=False ..."
export ANSIBLE_HOST_KEY_CHECKING=False


if [[ $INTERACTIVE == "false" ]]
then
    echo
    echo "Running in [quick,quiet,noprompt,non-interactive] mode ..."

    echo
    echo -e "Running Packer Build ...\n"

    _packerBuild
    sleep 5
    _getAMIid

    echo
    echo "Setting AMI ID -> $AMI_ID ..."
    export TF_VAR_swarm_ami_id=$AMI_ID

    echo
    echo "Running Swarm Init ..."
    terraform apply -input=false -auto-approve -target aws_instance.swarm-manager -var swarm_init=true -var swarm_managers=1

    echo
    echo -e "Getting Swarm Tokens ...\n"
    . ./swarm-getTokens.sh

    echo
    echo "Adding Swarm Nodes ..."
    terraform plan -out=tfplan.out -input=false
    terraform apply -input=false -auto-approve

    echo
    echo "Configuring for InSpec..."
    . ./build-inspec.sh

    echo
    echo "Running Ansible Playbook..."
    _ansiblePlaybook

    export swarm_manager_1_public_ip=$(terraform output swarm_manager_1_public_ip)

    echo
    echo -e "Swarm build is complete.\n"
    ssh -i ../../keys/projectX.key ubuntu@$(terraform output swarm_manager_1_public_ip) docker node ls

    echo
    echo -e "To connect to the swarm manager run 'ssh -i ../../keys/projectX.key ubuntu@$swarm_manager_1_public_ip'\n"

    _defaultServiceStack

    echo
    echo -e "buildIt.sh is complete.\n"

    return 0
fi


###                                     ###
### Section below = INTERACTIVE BUILD   ###
###                                     ###

echo
read -p "Would you like to build a new AMI via Packer? (only yes will proceed) > " yn

if [[ $yn == 'yes' ]]; then
    _packerBuild
fi

echo
echo "Building Docker Swarm with ingressIP [**redacted**] and ami ID: [$AMI_ID]"
echo -e "Current region [$AWS_DEFAULT_REGION]\n"
read -p "Do you wish to continue? (only yes will proceed) > " yn

if [[ $yn == 'yes' ]]; then
    echo
    echo -e "Building Swarm ...\n"

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
_ansiblePlaybook

export swarm_manager_1_public_ip=$(terraform output swarm_manager_1_public_ip)

echo "Swarm build is complete."
echo
ssh -i ../../keys/projectX.key ubuntu@$(terraform output swarm_manager_1_public_ip) docker node ls

echo
echo "To connect to the swarm manager run 'ssh -i ../../keys/projectX.key ubuntu@$swarm_manager_1_public_ip'"
echo

read -p "Would you like to deploy the Default Service Stack? (only yes will proceed) > " yn

if [[ $yn == 'yes' ]]; then
    _defaultServiceStack
else
    echo
    echo "buildIt.sh is complete."
    echo
fi
