data "template_file" "credentials" {
  template = "${file("${path.module}/vault_credentials.json.tpl")}"

  vars {
    username = "${random_string.username.result}"
    password = "${random_string.password.result}"
  }
}

resource "vault_generic_secret" "credentials" {
  path      = "secret/${var.service_name}/${var.service_version}/${var.env}/credentials"
  data_json = "${template_file.credentials.rendered}"
}
