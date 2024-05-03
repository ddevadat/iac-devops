terragrunt run-all init
cd istio-multi-primary-same-region-base-infra
rm -rf .terragrunt-cache
terragrunt apply -auto-approve --terragrunt-non-interactive

terragrunt run-all init
cd ../istio-multi-primary-same-region-oke-infra
rm -rf .terragrunt-cache
terragrunt apply -auto-approve --terragrunt-non-interactive


terragrunt run-all init
cd ../istio-multi-primary-same-region-setup
rm -rf .terragrunt-cache
terragrunt apply -auto-approve --terragrunt-non-interactive