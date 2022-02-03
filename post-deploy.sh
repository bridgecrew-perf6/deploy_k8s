#!/usr/bin/env bash
ansible-playbook playbook.yml -u vagrant -i ./hosts --extra-vars "ansible_sudo_pass=vagrant" --extra-vars "ansible_ssh_private_key_file=id_rsa" --ssh-extra-args '-o StrictHostKeyChecking=no'
