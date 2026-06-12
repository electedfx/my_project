terraform {
  required_providers {
    yandex = { source = "yandex-cloud/yandex" }
    local  = { source = "hashicorp/local" }
  }
}

provider "yandex" {
  #service_account_key_file = "${path.module}/sa-key.json"
  token     = var.yc_token
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

