//--------------------------------------------------------------------
// Variables

variable "server_pool_count" {
  default = 3
}

variable "service_name" {}

variable "service_version" {}

variable "system_user" {}
variable "system_password" {}

variable "organization" {}

variable "network_ws" {}

//--------------------------------------------------------------------
// Modules

provider "azurerm" {}

variable "resource_tags" {
  type = "map"

  default = {
    Owner       = "darnold"
    TTL         = 48
    ClusterName = "azure-bitcoin"
  }
}

//--------------------------------------------------------------------
data "terraform_remote_state" "network" {
  backend = "atlas"

  config {
    name = "${var.organization}/${var.network_ws}"
  }
}

module "server_pool" {
  source  = "app.terraform.io/Darnold-Hashicorp/server-pool/azurerm"
  version = "1.4.0"

  count           = "${var.server_pool_count}"
  resource_group  = "${data.terraform_remote_state.network.rg_name}"
  network_name    = "${data.terraform_remote_state.network.virtual_network_name}"
  subnet          = "${data.terraform_remote_state.network.rg_name}-subnet1"
  service_name    = "${var.service_name}"
  service_version = "${var.service_version}"
  location        = "${data.terraform_remote_state.network.location}"
  system_user     = "${var.system_user}"
  system_password = "${var.system_password}"
  failed = "true"
}
