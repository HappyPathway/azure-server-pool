variable "server_pool_count" {
  default = 3
}

variable "service_name" {}

variable "service_version" {}

variable "organization" {}

variable "network_ws" {}

variable "vault_cluster" {
  type        = "string"
  description = "Address of Vault Cluster"
}

variable "vault_token" {
  type        = "string"
  description = "Vault Token"
}

variable "env" {}
