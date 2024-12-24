###cloud vars
# variable "token" {
#   type        = string
#   description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
# }

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "resources_vm" {
  type = map(any)
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "preemptible"
}

variable "vm_web_nat" {
  type        = bool
  default     = false
  description = "nat enable"
}

variable "vm_web_user" {
  type        = string
  default     = "ubuntu"
  description = "default user"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v1"
  description = "platform of compute instanse"
}

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex_compute_image"
}

variable "metadata_map" {
  type = map(object({
    serial-port-enable = bool
    ssh-keys           = string
  }))
  default = {
    metadata = {
      serial-port-enable = true
      ssh-keys           = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF6BlRL7ju3oOkk33aTncS7h7aChx4ZIaUs8wipYkZFS dervish@devops"
    }
  }
}

variable "each_vm" {
  type = list(object({ vm_name = string, cpu = number, ram = number, disk_volume = number, core_fraction = number }))
  default = [
    { vm_name       = "main",
      cpu           = 4,
      ram           = 2,
      disk_volume   = 1
      core_fraction = 5
    },
    { vm_name       = "replica",
      cpu           = 2,
      ram           = 1,
      disk_volume   = 2
      core_fraction = 5
    }
  ]
}
