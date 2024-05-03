resource "oci_objectstorage_bucket" "test_bucket" {
    compartment_id = var.compartment_id
    name = "testbucket_tofu_test"
    namespace = var.namespace
}

variable "compartment_id" {
  type        = string
  description = "compartment ocid"
}

variable "namespace" {
  type        = string
  description = "oci namespace"
}

variable "region_1" {
  type        = string
  description = "The OCI region1"
}

variable "region_2" {
  type        = string
  description = "The OCI region2"
}