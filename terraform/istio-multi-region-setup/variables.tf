variable "ansible_collection_url" {
  default = "git+https://github.com/ddevadat/iac-devops.git#/ansible/istio/iac"
}

variable "ansible_collection_tag" {
  default = "main"
}

variable "ansible_base_output_dir" {
  description = "where to read/write ansible inv/etc"
  default = "/iac-run-dir/output"
}

variable "local_hosts_var_maps" {
  type = map
  description = "var map for local hosts"
}

variable "private_key" {
  type = string
  description = "oci api key"
}