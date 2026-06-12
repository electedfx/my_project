terraform {
  required_providers {
    yandex = { source = "yandex-cloud/yandex" }
    local  = { source = "hashicorp/local" }
  }
}

provider "yandex" {
  token     = "t1.9euelZqSkcvImsaXyJWdzMuPxsqTnO3rnpWajMrMy5OKm4qNzZKVl4yJnIvl8_dXJ1Au-e8-dUUg_t3z9xdWTS757z51RSD-zef1656VmsvHmM3GiZmdkJTIlMzLyM7J7_zF656VmsvHmM3GiZmdkJTIlMzLyM7JveuelZqKxorMiZuVx8qXiZvPj5qKirXrnpWal5OKxpeVj8qZypiVlpjJk8Y.0cf0J7yRTaFggJ764ZHt8arppEpRewSoGxIpEEow4H1KZUFzApOTjFFDBY7xI7PkUGpysCjP_EvBkmBrkmwRBA"
  folder_id = "b1gc3bh5hoi0vva6ch7n"
  zone      = var.yc_zone
}

module "builder" {
  source = "./builder"



}

module "runner" {
  source = "./runner"

 
}

resource "local_file" "ansible_inventory" {
  content  = templatefile("./inventory.tmpl.yml", {
    builder_ip = module.builder.public_ip
    runner_ip  = module.runner.public_ip
  })
  filename = "../ansible/inventory/hosts.yml"
}

