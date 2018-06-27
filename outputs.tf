output "hosts" {
  value = "${module.server_pool.ipaddresses}"
}
