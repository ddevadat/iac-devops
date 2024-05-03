terragrunt run-all init
cd opentofu-storage
rm -rf .terragrunt-cache
terragrunt apply -auto-approve --terragrunt-non-interactive
