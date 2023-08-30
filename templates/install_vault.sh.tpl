#!/usr/bin/env bash

imds_token=$( curl -Ss -H "X-aws-ec2-metadata-token-ttl-seconds: 30" -XPUT 169.254.169.254/latest/api/token )
instance_id=$( curl -Ss -H "X-aws-ec2-metadata-token: $imds_token" 169.254.169.254/latest/meta-data/instance-id )
local_ipv4=$( curl -Ss -H "X-aws-ec2-metadata-token: $imds_token" 169.254.169.254/latest/meta-data/local-ipv4 )

# install package

curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update
apt-get install -y vault-enterprise=${vault_version}+ent-* awscli jq

echo "Configuring system time"
timedatectl set-timezone UTC

cat << EOF > /opt/vault/vault.hclic
${vault_licence_content}
EOF

# vault.hclic should be readable by the vault group only
chown root:vault /opt/vault/vault.hclic
chmod 0640 /opt/vault/vault.hclic

cat << EOF > /etc/vault.d/vault.hcl
ui = true
disable_mlock = true

storage "raft" {
  path    = "/opt/vault/data"
  node_id = "$instance_id"
}

cluster_addr = "https://$local_ipv4:8201"
api_addr = "https://$local_ipv4:8200"

listener "tcp" {
  address            = "0.0.0.0:8200"
  tls_disable        = true
  #tls_disable        = false
  #tls_cert_file      = "/opt/vault/tls/vault-cert.pem"
  #tls_key_file       = "/opt/vault/tls/vault-key.pem"
  #tls_client_ca_file = "/opt/vault/tls/vault-ca.pem"
}

license_path = "/opt/vault/vault.hclic"

EOF

# vault.hcl should be readable by the vault group only
chown root:root /etc/vault.d
chown root:vault /etc/vault.d/vault.hcl
chmod 640 /etc/vault.d/vault.hcl

systemctl enable vault
systemctl start vault

echo "Setup Vault profile"
cat <<PROFILE | sudo tee /etc/profile.d/vault.sh
export VAULT_ADDR="http://127.0.0.1:8200"
PROFILE
