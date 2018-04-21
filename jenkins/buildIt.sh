#

echo
echo "Retrieving and setting Ingress IP..."
export TF_VAR_aws_ingressIP=$(curl --silent http://checkip.amazonaws.com)/32

echo "Retrieving and setting AMI ID..."
export TF_VAR_ami_id=$(aws ec2 describe-images \
    --owners self \
    --filters "Name=name,Values=ProjectX-Ubuntu-Docker" \
    | grep ami | cut -f2 -d: | sed -e 's/\"//g; s/,//; s/\ //g')


echo
echo "Building Jenkins infrastructure with ingressIP [***************]"
read -p "Do you wish to continue? (only yes will proceed) > " yn

if [[ $yn == 'yes' ]]; then
    echo
    echo "Building Jenkins infrastructure ..."

    echo "Setting ANSIBLE_HOST_KEY_CHECKING=False"
    export ANSIBLE_HOST_KEY_CHECKING=False
    echo

    terraform apply
else
    echo
    echo "Okay, terminating build."
    echo
    return 0
fi

echo
echo "Running Ansible Playbook..."
. ./ansible-run-playbook.sh

echo "Jenkins infrastructure build is complete."
echo

export jenkins_manager_public_ip=$(terraform output jenkins_manager_public_ip)

echo
echo "The Jenkins service can be reached at http://$jenkins_manager_public_ip"
echo "To connect to the Jenkins manager run 'ssh -i ../keys/projectX.key ubuntu@$jenkins_manager_public_ip'"
echo

