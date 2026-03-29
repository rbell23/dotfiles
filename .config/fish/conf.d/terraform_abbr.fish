#!/usr/bin/env fish
#
# terraform-abbr: terraform abbreviations for the fish shell
#
# Copyright (c) 2024 Robert Bell
# MIT License

# set -g __terrafrom_abbr_version 0.0.1

abbr tf 'terraform'

abbr tfi 'terraform init'

abbr tff 'terraform fmt'
abbr tffr 'terraform fmt --recursive'

abbr tfp 'terraform plan'

abbr tfa 'terraform apply'
abbr tfaaa 'terraform apply --auto-approve'

abbr tfd 'terraform destroy'
abbr tfdaa 'terraform destroy --auto-approve'

abbr tfc 'terraform console'

abbr tfstl 'terraform state list'
abbr tfsts 'terraform state show'

abbr tfv 'terraform validate'

abbr tft 'terraform test'
