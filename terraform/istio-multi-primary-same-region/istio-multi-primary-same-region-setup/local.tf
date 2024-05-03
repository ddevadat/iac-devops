locals {

  ansible_output_dir = "${var.ansible_base_output_dir}/istio-multi-primary-same-region-setup"

  local_scripts_location_map = {
    scripts_location = local.ansible_output_dir
  }
}