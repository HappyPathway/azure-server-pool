//--------------------------------------------------------------------
// Variables

//--------------------------------------------------------------------
// Modules

//--------------------------------------------------------------------
data "terraform_remote_state" "network" {
  backend = "atlas"

  config {
    name = "${var.organization}/${var.network_ws}"
  }
}

data "template_file" "userdata" {
  template = "${file("userdata.sh.tpl")}"

  vars {
    env                = "${var.env}"
    vault_token        = "${var.vault_token}"
    vault_addr         = "${var.vault_addr}"
    service_name       = "${var.service_name}"
  }
}

module "server_pool" {
  source  = "git@github.com:HappyPathway/terraform-azurerm-server-pool.git"
  version = "2.1.1"

  resource_group  = "${data.terraform_remote_state.network.rg_name}"
  network_name    = "${data.terraform_remote_state.network.virtual_network_name}"
  subnet          = "${data.terraform_remote_state.network.rg_name}-subnet1"
  service_name    = "${var.service_name}"
  service_version = "${var.service_version}"
  location        = "${data.terraform_remote_state.network.location}"
  system_user     = "${random_string.username.result}"
  system_password = "${random_string.password.result}"
  user_data       = "${data.template_file.userdata.rendered}"
  env             = "${var.env}"
  instance_size = "${var.instance_size}"
}
