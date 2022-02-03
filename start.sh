#!/usr/bin/env bash

# generate ssh key
if [ ! -f 'id_rsa' ]; then
    echo "\n\n" | ssh-keygen -f id_rsa
fi

# generate cloud-config user-data
public_key=$(cat id_rsa.pub)
user_data_file=packer/http/user-data
cat > $user_data_file <<- EOM
#cloud-config
autoinstall:
  version: 1
  identity:
    hostname: k8s
    username: vagrant
    # Generated via: printf vagrant | mkpasswd -m sha-512 -S vagrant. -s
    password: "\$6\$vagrant.\$sd6r0/OKL.FIGZbhanVkrLassSxoPRv1h5lkISsmBONqaLUGVXkEcD22Ddak5W8JSxeU0VFkU/We1Y7o4hVO/1"
  early-commands:
    # otherwise packer tries to connect and exceed max attempts:
    - systemctl stop ssh
  ssh:
    install-server: true
    authorized-keys:
    - "$public_key"
    allow-pw: no
  storage:
    layout:
      name: direct
  apt:
     package_update: true
     package_upgrade: false
EOM
packer build packer/ubuntu.pkr.hcl


echo yes | terraform apply
sleep 20
./post-deploy.sh
