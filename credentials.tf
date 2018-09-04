resource "random_string" "username" {
  length  = 24
  special = false
  keepers = {
    # Generate a new id each time we switch to a new AMI id
    ami_id = "${module.server_pool.ipaddress}"
  }
}

resource "random_string" "password" {
  length  = 24
  special = true
  keepers = {
    # Generate a new id each time we switch to a new AMI id
    ami_id = "${module.server_pool.ipaddress}"
  }
}
