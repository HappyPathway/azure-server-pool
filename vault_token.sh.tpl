export VAULT_TOKEN=${vault_token} 
export VAULT_ADDR=${vault_addr} 
vault token create -policy=${vault_policy} | grep -w token | awk '{ print $NF }' > /root/vault.token