

variable "tenancy_id" {
  description = "The tenancy id of the OCI Cloud Account in which to create the resources."
  type        = string
}

variable "compartment_id" {
  type        = string
  description = "compartment ocid"
}

variable "ad_count" {
  type        = number
  default     = 1
  description = "Number of ads"
}


variable "ad_number" {
  description = "the AD to place the operator host"
  default     = 1
  type        = number
}

variable "cls1_vcn_cidr" {
  default     = "10.0.0.0/16"
  type        = string
  description = "CIDR Subnet to use for the VCN, will be split into multiple /24s for the required private and public subnets"
}

variable "cls2_vcn_cidr" {
  default     = "10.0.0.0/16"
  type        = string
  description = "CIDR Subnet to use for the VCN, will be split into multiple /24s for the required private and public subnets"
}

variable "cls1_vcn_name" {
  default     = "cls1_vcn"
  type        = string
  description = "Cluster 1 VCN name"

}

variable "cls2_vcn_name" {
  default     = "cls2_vcn"
  type        = string
  description = "Cluster 2 VCN name"

}

variable "tags" {
  description = "Contains default tags for this project"
  type        = map(string)
  default     = {}
}


variable "region_1" {
  type        = string
  description = "The OCI region1"
}

variable "region_2" {
  type        = string
  description = "The OCI region2"
}

