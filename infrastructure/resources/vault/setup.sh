#!/bin/sh

VAULT_RETRIES=5
echo "Vault initiallization is starting..."
until vault status > /dev/null 2>&1 || [ "$VAULT_RETRIES" -eq 0 ]; do
        echo "Waiting for vault to start...: $((VAULT_RETRIES--))"
        sleep 1
done

vault secrets enable -version=1 kv

# Enable userpass and add default user
vault auth enable userpass
vault policy write root-policy /data/policy.hcl
vault write auth/userpass/users/admin password=password policies=root-policy

openssl genrsa -out /data/key.xxx 4096
openssl rsa -in /data/key.xxx -out /data/cert.xxx -pubout -outform PEM

cat /data/cert.xxx | vault kv put secret/consumer-daps-cert content=-
cat /data/key.xxx | vault kv put secret/consumer-daps-key content=-

cat /data/cert.xxx | vault kv put secret/oem-daps-cert content=-
cat /data/key.xxx | vault kv put secret/oem-daps-key content=-

cat /data/cert.xxx | vault kv put secret/tier1-daps-cert content=-
cat /data/key.xxx | vault kv put secret/tier1-daps-key content=-

vault kv put secret/symmetric-key content='c3ltbWV0cmljCg=='
vault kv put secret/sts-oem-secret content='xxx'
vault kv put secret/sts-supplier-secret content='xxx'
vault kv put secret/sts-consumer-secret content='xxx'
