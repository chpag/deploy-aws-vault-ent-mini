#!/usr/bin/env bash

# install package

curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update
apt-get install -y vault-enterprise=${vault_version}+ent-* awscli jq

echo "Configuring system time"
timedatectl set-timezone UTC

echo "Setup Vault profile"
cat <<PROFILE | sudo tee /etc/profile.d/vault.sh
export VAULT_ADDR="http://${vault_server}:8200"
PROFILE
