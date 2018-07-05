data 
resource "vault_generic_secret" "credentials" {
  path = "secret/${var.service_name}/${var.service_version}credentials"
