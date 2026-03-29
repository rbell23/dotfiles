function nl
    set -gx NOMAD_ADDR https://$argv[1].it-nomad.hashicorp.services:4646
    set -gx NOMAD_TOKEN (nomad login -method=Okta --json | jq -r '.SecretID')
end