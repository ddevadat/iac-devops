terraform {
  source = "git::${get_env("IAC_TERRAFORM_MODULES_REPO")}//terraform/oke-infra?ref=${get_env("IAC_TERRAFORM_MODULES_TAG")}"
}

generate "required_providers_override" {
  path = "required_providers_override.tf"

  if_exists = "overwrite_terragrunt"

  contents = <<EOF
terraform { 
  
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "${local.cloud_platform_vars.oci_provider_version}"
    }
  }
}
provider "oci" {
  alias            = "region_1"
  region           = "${local.env_vars.region_1}"
}
provider "oci" {
  alias            = "region_2"
  region           = "${local.env_vars.region_2}"
}
EOF
}

dependency "base_infra" {
  config_path = "../base-infra"
  mock_outputs = {
    cls1_vcn_id                   = "null"
    cls2_vcn_id                   = "null"
    cls1_rpc_id                   = "null"
    cls2_rpc_id                   = "null"
    cls1_private_sub_1_id         = "null"
    cls1_public_sub_1_id          = "null"
    cls1_public_sub_2_id          = "null"
    cls1_private_sub_1_cidr_block = "null"
    cls1_public_sub_1_cidr_block  = "null"
    cls1_public_sub_2_cidr_block  = "null"
    cls2_private_sub_1_id         = "null"
    cls2_public_sub_1_id          = "null"
    cls2_public_sub_2_id          = "null"
    cls2_private_sub_1_cidr_block = "null"
    cls2_public_sub_1_cidr_block  = "null"
    cls2_public_sub_2_cidr_block  = "null"
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "show"]
  mock_outputs_merge_strategy_with_state  = "shallow"
}

inputs = {
  cls1_vcn_id                   = dependency.base_infra.outputs.cls1_vcn_id
  cls2_vcn_id                   = dependency.base_infra.outputs.cls2_vcn_id
  cls1_rpc_id                   = dependency.base_infra.outputs.cls1_rpc_id
  cls2_rpc_id                   = dependency.base_infra.outputs.cls2_rpc_id
  cls1_private_sub_1_id         = dependency.base_infra.outputs.cls1_private_sub_1_id
  cls1_public_sub_1_id          = dependency.base_infra.outputs.cls1_public_sub_1_id
  cls1_public_sub_2_id          = dependency.base_infra.outputs.cls1_public_sub_2_id
  cls1_private_sub_1_cidr_block = dependency.base_infra.outputs.cls1_private_sub_1_cidr_block
  cls1_public_sub_1_cidr_block  = dependency.base_infra.outputs.cls1_public_sub_1_cidr_block
  cls1_public_sub_2_cidr_block  = dependency.base_infra.outputs.cls1_public_sub_2_cidr_block
  cls2_private_sub_1_id         = dependency.base_infra.outputs.cls2_private_sub_1_id
  cls2_public_sub_1_id          = dependency.base_infra.outputs.cls2_public_sub_1_id
  cls2_public_sub_2_id          = dependency.base_infra.outputs.cls2_public_sub_2_id
  cls2_private_sub_1_cidr_block = dependency.base_infra.outputs.cls2_private_sub_1_cidr_block
  cls2_public_sub_1_cidr_block  = dependency.base_infra.outputs.cls2_public_sub_1_cidr_block
  cls2_public_sub_2_cidr_block  = dependency.base_infra.outputs.cls2_public_sub_2_cidr_block
  region_1                      = local.env_vars.region_1
  region_2                      = local.env_vars.region_2
  ad_count                      = local.env_vars.ad_count
  tenancy_id                    = local.env_vars.tenancy_id
  compartment_id                = local.env_vars.compartment_id
}

locals {
  env_vars = yamldecode(
  file("${find_in_parent_folders("environment.yaml")}"))
  cloud_platform_vars = yamldecode(
    file("${find_in_parent_folders("${get_env("CONTROL_CENTER_CLOUD_PROVIDER")}-vars.yaml")}")
  )
}

include "root" {
  path = find_in_parent_folders()
}
