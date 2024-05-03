terraform {
  source = "git::${get_env("IAC_TERRAFORM_MODULES_REPO")}//terraform/opentofu/storage?ref=${get_env("IAC_TERRAFORM_MODULES_TAG")}"
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


inputs = {
  ad_count       = local.env_vars.ad_count
  tenancy_id     = local.env_vars.tenancy_id
  compartment_id = local.env_vars.compartment_id
  region_1       = local.env_vars.region_1
  region_2       = local.env_vars.region_2
  namespace      = local.env_vars.namespace
}

locals {
  env_vars = yamldecode(
    file("${find_in_parent_folders("environment.yaml")}")
  )
  cloud_platform_vars = yamldecode(
    file("${find_in_parent_folders("${get_env("CONTROL_CENTER_CLOUD_PROVIDER")}-vars.yaml")}")
  )
}

include "root" {
  path = find_in_parent_folders()
}