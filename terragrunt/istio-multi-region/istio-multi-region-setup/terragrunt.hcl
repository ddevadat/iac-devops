terraform {
  source = "git::${get_env("IAC_TERRAFORM_MODULES_REPO")}//terraform/istio-multi-region/istio-multi-region-setup?ref=${get_env("IAC_TERRAFORM_MODULES_TAG")}"
}

dependency "istio_infra" {
  config_path = "../oke-infra"
  mock_outputs = {
    local_hosts_var_maps = {}
    cls1_kubeconfig      = "null"
    cls2_kubeconfig      = "null"

  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "show"]
  mock_outputs_merge_strategy_with_state  = "shallow"
}

inputs = {
  local_hosts_var_maps    = dependency.istio_infra.outputs.local_hosts_var_maps
  cls1_kubeconfig         = dependency.istio_infra.outputs.cls1_kubeconfig
  cls2_kubeconfig         = dependency.istio_infra.outputs.cls2_kubeconfig
  region_1                = local.env_vars.region_1
  region_2                = local.env_vars.region_2
  ansible_collection_tag  = local.env_vars.ansible_collection_tag
  ansible_collection_url  = local.env_vars.ansible_collection_url
  ansible_base_output_dir = get_env("ANSIBLE_BASE_OUTPUT_DIR")
}

locals {
  env_vars = yamldecode(
  file("${find_in_parent_folders("environment.yaml")}"))
}

include "root" {
  path = find_in_parent_folders()
}
