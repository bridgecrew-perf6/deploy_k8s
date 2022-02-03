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
