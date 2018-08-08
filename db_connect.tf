module "db-connect" {
  source  = "app.terraform.io/Darnold-AzureTF/db-connect/azure"
  version = "1.0.0"
  access_name = "${var.service_name}"
  db_server_name = "${var.db_server_name}"
  ip_address = "${module.server_pool.ipaddress}"
  resource_group = "${data.terraform_remote_state.network.rg_name}"

}