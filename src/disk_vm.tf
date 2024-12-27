resource "yandex_compute_disk" "external" {
  count = var.vm_ext_disks # 3
  name  = "ext-disk-${count.index}"
  size  = var.vm_ext_disk_size # 1Gb
  type  = var.vm_ext_disk_type
  zone  = var.default_zone
}

resource "yandex_compute_instance" "storage" {

  name        = "storage"
  hostname    = "storage"
  platform_id = var.vm_web_platform
  zone        = var.default_zone

  resources {
    cores         = var.resources_vm["cores"]
    memory        = var.resources_vm["memory"]
    core_fraction = var.resources_vm["core_fraction"]
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.external.*.id
    content {
      //disk_id = yandex_compute_disk.external["${secondary_disk.key}"].id
      disk_id = yandex_compute_disk.external[secondary_disk.key].id
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
    ssh-keys           = "${var.vm_web_user}:${var.metadata_map.metadata.ssh-keys}"
  }
}
