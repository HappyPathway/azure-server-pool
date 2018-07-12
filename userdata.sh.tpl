#!/bin/bash
apt-get update -y
apt-get install -y python-dev python-pip python-setuptools python wget unzip

wget https://releases.hashicorp.com/vault/0.10.3/vault_0.10.3_linux_amd64.zip -O /tmp/vault.zip
unzip /tmp/vault.zip -d /usr/local/bin

export VAULT_ADDR=${vault_addr}
export VAULT_TOKEN=${vault_token}
echo "export VAULT_ADDR=${vault_addr}" >> /etc/profile.d/vault.sh
echo "export VAULT_TOKEN=${vault_token}" >> /etc/profile.d/vault.sh

vault read -field=public_key ssh-${service_name}-${env}/config/ca > /etc/ssh/trusted-user-ca-keys.pem
vault write -field=signed_key ssh-${service_name}-${env}/sign/host cert_type=host public_key=@/etc/ssh/ssh_host_rsa_key.pub > /etc/ssh/ssh_host_rsa_key-cert.pub
chmod 0640 /etc/ssh/ssh_host_rsa_key-cert.pub

mv /etc/ssh/sshd_config /etc/ssh/sshd_config.bkup
cat <<EOF > /etc/ssh/sshd_config
Port 22
Protocol 2
HostCertificate /etc/ssh/ssh_host_rsa_key-cert.pub
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_dsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key
UsePrivilegeSeparation yes
KeyRegenerationInterval 3600
ServerKeyBits 1024
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin prohibit-password
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PasswordAuthentication no
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes
TrustedUserCAKeys /etc/ssh/trusted-user-ca-keys.pem
EOF

# service ssh restart