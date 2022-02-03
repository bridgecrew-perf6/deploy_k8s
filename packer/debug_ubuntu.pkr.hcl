source "qemu" "exampledebug" {
  iso_url           = "packer/output_ubuntu/tdhtest"
  iso_checksum      = "none"
  output_directory  = "packer/output_debug_ubuntu"
  shutdown_command  = "echo 'vagrant' | sudo -S shutdown -P now"
  disk_image        = true
  disk_size         = "5000M"
  format            = "qcow2"
  memory            = 4096
  cpus              = 4
  accelerator       = "kvm"
  http_directory    = "packer/http"
  ssh_username      = "vagrant"
  ssh_password      = "vagrant"
  ssh_private_key_file = "id_rsa"
  ssh_timeout       = "20m"
  vm_name           = "tdhtest"
  net_device        = "virtio-net"
  disk_interface    = "virtio"
  boot_wait         = "3s"
}

build {
  sources = ["source.qemu.exampledebug"]
  provisioner "ansible" {
    playbook_file = "packer/playbook.yml"
    user = "vagrant"
    use_proxy       = false
    extra_arguments = [
      "-e",
      "ansible_sudo_pass=vagrant"
    ]
  }
}

