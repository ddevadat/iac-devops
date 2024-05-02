variable "compartment_id" {
  type        = string
  description = "compartment ocid"
}

variable "tenancy_id" {
  description = "The tenancy id of the OCI Cloud Account in which to create the resources."
  type        = string
}


variable "ad_number" {
  description = "the AD to place the operator host"
  default     = 1
  type        = number
}


variable "tags" {
  description = "Contains default tags for this project"
  type        = map(string)
  default     = {}
}

variable "cls1_vcn_id" {
  type        = string
  description = "VCN id for creating oke"
}

variable "cls2_vcn_id" {
  type        = string
  description = "VCN id for creating oke"
}

variable "cls1_rpc_id" {
  type        = string
  description = "RPC id for VCN"
}

variable "cls2_rpc_id" {
  type        = string
  description = "RPC id for VCN"
}

variable "ad_count" {
  type        = number
  default     = 1
  description = "Number of ads"
}


variable "user_ocid" {
  type        = string
  description = "The OCI user"
}

variable "flannel_pods_cidr" {
  type        = string
  default     = "10.244.0.0/16"
  description = "Pods CIDR for Flannel"
}

variable "k8s_cluster_properties" {
  default = {
    shape                   = "VM.Standard.E4.Flex"
    ocpus                   = 2
    memory                  = 16
    boot_volume_size        = 50
    node_pool_size          = 3
    worker_image_os_version = 7.9
    cni : "flannel"
  }
  description = "Default oke properties"
  type        = map(any)
}



variable "cls1_private_sub_1_id" {
  description = "Base Infra private subnet id"
  type        = string
}

variable "cls1_private_sub_1_cidr_block" {
  description = "Base Infra private subnet cidr block"
  type        = string
}


variable "cls1_public_sub_1_id" {
  description = "Base Infra public subnet id"
  type        = string
}

variable "cls1_public_sub_1_cidr_block" {
  description = "Base Infra public subnet cidr block"
  type        = string
}

variable "cls1_public_sub_2_id" {
  description = "Base Infra public subnet id"
  type        = string
}

variable "cls1_public_sub_2_cidr_block" {
  description = "Base Infra public subnet cidr block"
  type        = string
}

###


variable "cls2_private_sub_1_id" {
  description = "Base Infra private subnet id"
  type        = string
}

variable "cls2_private_sub_1_cidr_block" {
  description = "Base Infra private subnet cidr block"
  type        = string
}


variable "cls2_public_sub_1_id" {
  description = "Base Infra public subnet id"
  type        = string
}

variable "cls2_public_sub_1_cidr_block" {
  description = "Base Infra public subnet cidr block"
  type        = string
}

variable "cls2_public_sub_2_id" {
  description = "Base Infra public subnet id"
  type        = string
}

variable "cls2_public_sub_2_cidr_block" {
  description = "Base Infra public subnet cidr block"
  type        = string
}
##
variable "k8s_allow_rules_public_lb" {
  default = {}
  type    = any
}


variable "region_1" {
  type        = string
  description = "The OCI region1"
}

variable "region_2" {
  type        = string
  description = "The OCI region2"
}
