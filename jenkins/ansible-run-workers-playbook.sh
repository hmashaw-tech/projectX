#

echo
echo "Running Ansible Workers playbook..."
read -p "Do you wish to continue? (only yes will proceed) > " yn

if [[ $yn == 'yes' ]]; then
    ansible-playbook -i ansible-inventory --private-key ../keys/projectX.key ansible-playbook-workers.yml
else
    echo
    echo "Okay, skipping section."
    echo
fi

