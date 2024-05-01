terraform {
  source = "git::${get_env("IAC_TERRAFORM_MODULES_REPO")}//terraform/istio-multi-region-setup?ref=${get_env("IAC_TERRAFORM_MODULES_TAG")}"
}

dependency "istio_infra" {
  config_path = "../base-infra"
  mock_outputs = {
    local_hosts_var_maps = {}
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "show"]
  mock_outputs_merge_strategy_with_state  = "shallow"
}

inputs = {
  local_hosts_var_maps         = dependency.istio_infra.outputs.local_hosts_var_maps
  ansible_collection_tag       = local.env_vars.ansible_collection_tag
  ansible_collection_url       = local.env_vars.ansible_collection_url
  ansible_base_output_dir      = get_env("ANSIBLE_BASE_OUTPUT_DIR")
}

locals {
  env_vars = yamldecode(
  file("${find_in_parent_folders("environment.yaml")}"))
}

include "root" {
  path = find_in_parent_folders()
}