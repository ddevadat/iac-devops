variable "ansible_collection_url" {
  default = "git+https://github.com/ddevadat/iac-devops.git#/ansible/istio/iac"
}

variable "ansible_collection_tag" {
  default = "main"
}

variable "ansible_base_output_dir" {
  description = "where to read/write ansible inv/etc"
  default     = "/iac-run-dir/output"
}

variable "local_hosts_var_maps" {
  type        = map(any)
  description = "var map for local hosts"
}

variable "private_key" {
  type        = string
  description = "oci api key"
}

variable "tenancy_ocid" {
  type        = string
  description = "oci tenancy id"
}

variable "user_ocid" {
  type        = string
  description = "oci user id"
}

variable "fingerprint" {
  type        = string
  description = "oci user fingerprint"
}

variable "region_1" {
  type        = string
  description = "The OCI region1"
}

variable "region_2" {
  type        = string
  description = "The OCI region2"
}

variable "cls1_kubeconfig" {
  type        = string
  description = "The oke kubeconfig"
}

variable "cls2_kubeconfig" {
  type        = string
  description = "The oke kubeconfig"
}