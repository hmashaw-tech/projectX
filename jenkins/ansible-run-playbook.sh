#

echo
echo "Running Ansible Baseline & Website Config..."
read -p "Do you wish to continue? (only yes will proceed) > " yn

if [[ $yn == 'yes' ]]; then
    ansible-playbook -i ansible-inventory --private-key ../keys/projectX.key --tags "baseline,website" ansible-playbook.yml
else
    echo
    echo "Okay, skipping section."
    echo
fi


echo
echo "Running Initial Ansible NGINX & Jenkins Config.  Get Cert..."
read -p "Do you wish to continue? (only yes will proceed) > " yn

if [[ $yn == 'yes' ]]; then
    ansible-playbook -i ansible-inventory --private-key ../keys/projectX.key --tags "nginx,jenkins,certbot" ansible-playbook.yml
else
    echo
    echo "Okay, skipping section."
    echo
fi


echo
echo "Running Ansible - Only Jenkins Cert config."
read -p "Do you wish to continue? (only yes will proceed) > " yn

if [[ $yn == 'yes' ]]; then
    ansible-playbook -i ansible-inventory --private-key ../keys/projectX.key --tags "onlyJenkinsCert" ansible-playbook.yml
else
    echo
    echo "Okay, terminating Ansible."
    echo
    return 0
fi

