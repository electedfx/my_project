terraform {
  required_version = ">= 1.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.130"
    }
  }
}


data "yandex_compute_image" "os_image" {
  family = var.yc_vm_os_family
}

resource "yandex_compute_instance" "builder_vm" {
  name        = var.yc_vm_name
  hostname    = var.yc_vm_hostname
  platform_id = var.yc_platform_id
  zone        = var.yc_zone

  resources {
    cores         = var.yc_vm_cores
    memory        = var.yc_vm_ram
    core_fraction = var.yc_vm_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.yc_vm_boot_disk_image_id
      size     = var.yc_vm_disk_size
      type     = var.yc_vm_disk_type
    }
  }

  scheduling_policy {
    preemptible = var.yc_vm_preemptible
  }

  network_interface {
    subnet_id          = var.yc_vm_subnet_id
    nat                = var.yc_vm_assign_public_ip
    security_group_ids = var.yc_vm_security_group_ids
  }

  metadata = {
    user-data = file("${path.module}/vm_cloud_init.yaml")
  }

}