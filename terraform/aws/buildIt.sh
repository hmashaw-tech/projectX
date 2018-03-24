#

if [[ -z $2 ]]; then
    echo "buildIt.sh takes exactly two args: <ingressIP> <swarm_ami_id>"
    exit
fi
echo ""

echo "Building Docker Swarm with ingressIP [$1] and ami ID: [$2]"
read -p "Do you wish to continue? (only yes will proceed) > " yn

if [[ $yn == 'yes' ]]; then
    echo ""
    echo "Building Swarm ..."

    ingressIP=$1/32
    echo "Setting Ingress IP -> $ingressIP ..."
    export TF_VAR_swarm_ingressIP=$ingressIP

    echo "Setting AMI ID -> $2 ..."
    export TF_VAR_swarm_ami_id=$2

    echo "Setting ANSIBLE_HOST_KEY_CHECKING"
    export ANSIBLE_HOST_KEY_CHECKING=False

    echo "Running Swarm Init ..."
    . ./swarm-init.sh

    echo "Getting Swarm Tokens ..."
    . ./swarm-tokens.sh

    echo "Running Terraform plan ..."
    terraform plan

    terraform plan
    echo "To continue and add swarm workers, run terraform apply..."
else
    echo "Okay, stopping build."
fi

echo ""
