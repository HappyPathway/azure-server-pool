//--------------------------------------------------------------------
// Variables

variable "server_pool_count" {
  default = 3
}

variable "service_name" {}

variable "env" {}

//--------------------------------------------------------------------
// Modules
module "network" {
  source  = "app.terraform.io/Darnold-Hashicorp/network/azurerm"
  version = "1.0.5"
  env     = "${var.env}"
}

module "server_pool" {
  source  = "app.terraform.io/Darnold-Hashicorp/server-pool/azurerm"
  version = "1.0.5"

  count          = "${var.server_pool_count}"
  network_name   = "${module.network.rg_name}"
  resource_group = "${var.env}"
  subnet         = "${module.network.subnet}"
  env            = "${var.env}"
  service_name   = "${var.service_name}"
  location       = "${module.network.location}"
}
