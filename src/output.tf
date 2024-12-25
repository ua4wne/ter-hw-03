output "web_servers" {
  description = "web_servers params"
  value = [
    for vm in yandex_compute_instance.web :
    zipmap(["name","id","fqdn"],[vm.name, vm.id, vm.fqdn])
  ]
}

output "db_servers" {
  description = "db_servers params"
  value = [
    for vm in yandex_compute_instance.db :
    zipmap(["name","id","fqdn"],[vm.name, vm.id, vm.fqdn])
  ]
}
