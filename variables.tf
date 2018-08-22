variable "server_pool_count" {
  default = 3
}

variable "service_name" {}

variable "service_version" {}

variable "organization" {}

variable "network_ws" {}

variable "env" {}

variable "default_lease_ttl" {
  default = 300
}

variable "max_lease_ttl" {
  default = 600
}

variable "vault_addr" {
  type = "string"
  description = "Address of Vault Cluster. Including HTTP Scheme"
}

variable "vault_token" {
  type = "string"
  description = "Vault Token"
}

variable "instance_type" {
  type = "string"
  description = "Azure Instance Type"
}
