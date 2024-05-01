terragrunt run-all init
cd base-infra
rm -rf .terragrunt-cache
terragrunt apply -auto-approve --terragrunt-non-interactive