export VAULT_TOKEN=${vault_token} 
export VAULT_ADDR=${vault_addr} 
token_json=$(vault token create -policy=${vault_policy} | grep -w token | awk '{ printf "{\"token\": \"%s\"}", $NF }')
echo $${token_json}