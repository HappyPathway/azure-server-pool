variable "server_pool_count" {
  default = 3
}

variable "service_name" {}

variable "service_version" {}

variable "organization" {}

variable "network_ws" {}

variable "vault_addr" {
  type        = "string"
  description = "Address of Vault Cluster"
}

variable "vault_token" {
  type        = "string"
  description = "Vault Token"
}

variable "env" {}

variable "default_lease_ttl" {
  default = 300
}

variable "max_lease_ttl" {
  default = 600
}

variable "app_role_secret_id" {
  type        = "string"
  description = "App Role Secret ID"
}

variable "db_server_name" {
  type = "string"
  description = "Database Server Name"
}