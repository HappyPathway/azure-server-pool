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
  version = "1.0.10"
  env     = "${var.env}"
}

module "server_pool" {
  source  = "app.terraform.io/Darnold-Hashicorp/server-pool/azurerm"
  version = "1.0.6"

  count          = "${var.server_pool_count}"
  resource_group = "${var.env}"
  subnet         = "${var.env}-subnet1"
  env            = "${var.env}"
  service_name   = "${var.service_name}"
  location       = "${module.network.location}"
}
