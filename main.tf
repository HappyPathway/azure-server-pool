//--------------------------------------------------------------------
// Variables

variable "server_pool_count" {}
variable "server_pool_subnet_name" {}
variable "server_pool_version" {}

//--------------------------------------------------------------------
// Modules
module "network" {
  source  = "app.terraform.io/Darnold-Hashicorp/network/azurerm"
  version = "1.0.1"
  env     = "${var.env}"
}

module "server_pool" {
  source  = "app.terraform.io/Darnold-Hashicorp/server-pool/azurerm"
  version = "1.0.1"

  count          = "${var.server_pool_count}"
  network_name   = "${module.network.rg_name}"
  resource_group = "${module.network.resource_group}"
  subnet_name    = "${var.server_pool_subnet_name}"
  version        = "${var.server_pool_version}"
  env            = "${var.env}"
  service_name   = "${var.service_name}"
  location       = "${module.network.location}"
}
