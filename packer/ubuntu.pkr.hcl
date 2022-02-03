source "qemu" "example" {
  iso_url           = "https://ubuntu.ccns.ncku.edu.tw/ubuntu-cd/20.04.3/ubuntu-20.04.3-live-server-amd64.iso"
  iso_checksum      = "none"
  output_directory  = "packer/output_ubuntu"
  shutdown_command  = "echo 'vagrant' | sudo -S shutdown -P now"
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
  boot_command      = ["<enter><enter><f6><esc><wait> ",
        "autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
        "<enter><wait>"]
}

build {
  sources = ["source.qemu.example"]
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

