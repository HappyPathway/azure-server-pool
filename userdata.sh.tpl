#!/bin/bash
apt-get update -y
apt-get install -y python-dev python-pip python-setuptools python wget unzip

wget https://releases.hashicorp.com/vault/0.10.3/vault_0.10.3_linux_amd64.zip -O /tmp/vault.zip
unzip /tmp/vault.zip -d /usr/local/bin

export VAULT_ADDR=${vault_addr}
export VAULT_TOKEN=${vault_token}
echo "export VAULT_ADDR=${vault_addr}" >> /etc/profile.d/vault.sh
echo "export VAULT_TOKEN=${vault_token}" >> /etc/profile.d/vault.sh
