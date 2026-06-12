variable "yc_vm_os_family" {
  description = "OS family"
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "yc_vm_name" {
  description = "VM name"
  type        = string
  default     = "runner"
}

variable "yc_vm_hostname" {
  description = "VM Hostname"
  type        = string
  default     = "appsrv"
}

variable "yc_platform_id" {
  description = "Cloud platform ID"
  type        = string
  default     = "standard-v4a"
}

variable "yc_zone" {
  description = "YC zone"
  type        = string
  default     = "ru-central1-d"
}

variable "yc_vm_cores" {
  description = "VM vCPU number"
  type        = number
  default     = 2
}

variable "yc_vm_ram" {
  description = "VM RAM, gb"
  type        = number
  default     = 2
}

variable "yc_vm_core_fraction" {
  description = "Guaranteed vCPU share (20/50/100)"
  type        = number
  default     = 100
}

variable "yc_vm_preemptible" {
  description = "preemptible VM"
  type        = bool
  default     = false
}

variable "yc_vm_boot_disk_image_id" {
  description = "VM boot image ID"
  type        = string
  default     = "fd8lp60fqu55vosk2hup"
}

variable "yc_vm_disk_type" {
  description = "Disk type"
  type        = string
  default     = "network-ssd"
}

variable "yc_vm_disk_size" {
  description = "Boot disk size, Gb"
  type        = number
  default     = 20
}

variable "yc_vm_subnet_id" {
  description = "network ID"
  type        = string
  default     = "fl81ed0u0lg91husofkr"
}

variable "yc_vm_assign_public_ip" {
  description = "Assign public IP to VM"
  type        = bool
  default     = true
}

variable "yc_vm_security_group_ids" {
  description = "Security group list"
  type        = list(string)
  default     = ["enpoj8jrko9rsm0m0ump"]
}

variable "yc_vm_ssh_login" {
  description = "SSH user"
  type        = string
  default     = "superuser"
}

variable "yc_vm_ssh_public_key_path" {
  description = "SSH key path"
  type = string
  default = "../keys/study4.pub"
}

variable "yc_vm_cloud_init_config" {
  description = "VM cloud init config path"
  type = string
  default = "vm_cloud_init.yaml"
}

