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
