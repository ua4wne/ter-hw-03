resource "yandex_compute_instance" "db" {
  for_each    = { for env in var.each_vm : env.vm_name => env }
  name        = each.value.vm_name
  hostname    = each.value.vm_name
  platform_id = each.value.platform
  zone        = each.value.zone

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.vm_web_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = var.metadata_map.metadata.serial-port-enable
    ssh-keys           = "${var.vm_web_user}:${local.ssh-keys}"
  }
}

locals {
  ssh-keys = file("~/.ssh/id_ed25519.pub")
}
