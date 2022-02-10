## Repository

自動化建構 libvirt(virtual manager) 上的 Kubernetes cluster

## Purpose

這個 Repository 的目的是為了學習自動部署，以及學習建構 Kubernetes

Study:
- Packer
- Ansible
- Terraform
- Kubernetes

## Dependency packages

必須事先安裝以下 packages:
- terraform
- packer
- sshpass
- ansible
- libvirt

## Auto-deploy flow

自動部署流程:
1. Packer + Ansible build image
2. Terraform creates virtual machines
3. Ansible deploy Kubernetes machines

## Build environment
1. Download repository.
2. Initialize terraform environment.
3. Run script.

```bash
git clone git@github.com:sauinana/deploy_k8s.git
cd deploy_k8s
terraform init
./start.sh
```

## Destroy environment
```bash
terraform destroy
```
## Use
1. How to login guests?

use the generated key id_rsa to login
```bash
ssh vagrant@10.17.3.3 -i id_rsa
```
default user name / password
user name: vagrant
password: vagrant

2. How to use Kubernetes?

copy kubernetes configuration files to local `$HOME/.kube/config`
```text
copy kubernetes master's /etc/kubernetes/admin.conf to local $HOME/.kube/config
```
then can use kubectl commands on local.
