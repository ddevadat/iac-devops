terragrunt run-all init
cd base-infra
rm -rf .terragrunt-cache
terragrunt apply -auto-approve --terragrunt-non-interactive

cd ../oke-infra
rm -rf .terragrunt-cache
terragrunt apply -auto-approve --terragrunt-non-interactive

cd ../istio-multi-region-setup
rm -rf .terragrunt-cache
terragrunt apply -auto-approve --terragrunt-non-interactive