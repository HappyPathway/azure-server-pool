resource "vault_mount" "ssh_mount" {
  path                      = "ssh-${var.service_name}-${var.env}"
  type                      = "ssh"
  description               = "Enabling SSH Dev"
  default_lease_ttl_seconds = "${var.default_lease_ttl}"
  max_lease_ttl_seconds     = "${var.max_lease_ttl}"
}

# vault write ssh-production/config/ca generate_signing_key=true
resource "vault_generic_secret" "ssh_signing" {
  path      = "ssh-${var.service_name}-${var.env}/config/ca"
  data_json = "${file("./ssh_roles/generate_signing.json")}"

  depends_on = [
    "vault_mount.ssh_mount",
  ]
}

resource "vault_generic_secret" "ssh_host_signing" {
  path      = "ssh-${var.service_name}-${var.env}/roles/host"
  data_json = "${file("./ssh_roles/ssh_host_signing.json")}"

  depends_on = [
    "vault_mount.ssh_mount",
  ]
}

data "template_file" "user" {
  template = "${file("./ssh_roles/user.json.tpl")}"

  vars {
    user = "${random_string.username.result}"
  }
}

resource "vault_generic_secret" "ssh_user" {
  path      = "ssh-${var.service_name}-${var.env}/roles/dev"
  data_json = "${data.template_file.user.rendered}"

  depends_on = [
    "vault_mount.ssh_mount",
  ]
}

resource "vault_generic_secret" "ssh_root" {
  path      = "ssh-${var.service_name}-${var.env}/roles/root"
  data_json = "${file("./ssh_roles/root.json")}"

  depends_on = [
    "vault_mount.ssh_mount",
  ]
}

data "template_file" "vault_policy" {
  template = "${file("${path.module}/vault_policies/ssh_access.hcl.tpl")}"

  vars {
    env          = "${var.env}"
    service_name = "${var.service_name}"
  }
}

resource "vault_policy" "ssh_key_access" {
  name   = "ssh-${var.service_name}-${var.env}-access"
  policy = "${data.template_file.vault_policy.rendered}"
}
