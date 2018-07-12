path "ssh-${service_name}-${env}/config/ca" {
  capabilities = ["read", "list"]
}

path "ssh-${service_name}-${env}/sign/host" {
    capabilities = ["write", "update"]
}