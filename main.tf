terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  # Configuration options
  uri = "qemu:///system"
}

resource "libvirt_volume" "leap" {
  name   = "leap"
  source = "packer/output_ubuntu/tdhtest"
}

resource "libvirt_volume" "mydisk1" {
  name           = "mydisk1"
  size           = 21474836480
  base_volume_id = libvirt_volume.leap.id
}
resource "libvirt_volume" "mydiskw1" {
  name           = "mydiskw1"
  size           = 21474836480
  base_volume_id = libvirt_volume.leap.id
}
resource "libvirt_volume" "mydiskw2" {
  name           = "mydiskw2"
  size           = 21474836480
  base_volume_id = libvirt_volume.leap.id
}

resource "libvirt_network" "kube_network" {
  name = "k8snet"
  mode = "nat"
  domain = "k8s.local"
  addresses = ["10.17.3.0/24"]
  dns {
    enabled = true
  }

  dnsmasq_options {
  }

}
resource "libvirt_domain" "k8s1" {
  name = "k8s1"
  memory = 10240
  vcpu = 2
  cmdline     = []
  disk {
    volume_id = libvirt_volume.mydisk1.id
    scsi      = "true"
  }
  network_interface {
    network_id     = libvirt_network.kube_network.id
    hostname       = "master"
    addresses      = ["10.17.3.3"]
    mac            = "AA:BB:CC:11:22:23"
    wait_for_lease = false
  }

}
resource "libvirt_domain" "k8sw1" {
  name = "k8sw1"
  memory = 10240
  vcpu = 4
  cmdline     = []
  disk {
    volume_id = libvirt_volume.mydiskw1.id
    scsi      = "true"
  }
  network_interface {
    network_id     = libvirt_network.kube_network.id
    hostname       = "worker1"
    addresses      = ["10.17.3.4"]
    mac            = "AA:BB:CC:11:22:24"
    wait_for_lease = false
  }

}
resource "libvirt_domain" "k8sw2" {
  name = "k8sw2"
  memory = 10240
  vcpu = 4
  cmdline     = []
  disk {
    volume_id = libvirt_volume.mydiskw2.id
    scsi      = "true"
  }
  network_interface {
    network_id     = libvirt_network.kube_network.id
    hostname       = "worker2"
    addresses      = ["10.17.3.5"]
    mac            = "AA:BB:CC:11:22:25"
    wait_for_lease = false
  }

}
