output "public_ip" {
  description = "VM white ip"
  value       = yandex_compute_instance.builder_vm.network_interface[0].nat_ip_address
}