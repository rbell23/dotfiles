function vl
    set -gx VAULT_ADDR https://$argv[1].it-vault.hashicorp.services
    vault login -method=oidc -path=it-engineering-cloud-oidc role=it-engineering-cloud
end