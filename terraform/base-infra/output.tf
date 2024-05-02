output "local_hosts_var_maps" {
  value = {
    ansible_ssh_common_args          = "-o StrictHostKeyChecking=no"
    cls1_vcn_id                      = module.cls1_vcn.vcn_id
    cls2_vcn_id                      = module.cls2_vcn.vcn_id
    cls1_rpc_id                      = oci_core_remote_peering_connection.cls1_remote_peering_connection.id
    cls2_rpc_id                      = oci_core_remote_peering_connection.cls2_remote_peering_connection.id
    cls1_region_1                    = var.region_1
    cls2_region_2                    = var.region_2
    compartment_id                   = var.compartment_id
    dummy                            = "dummy"
  }
}


output "cls1_vcn_id" {
  value = module.cls1_vcn.vcn_id
}

output "cls2_vcn_id" {
  value = module.cls2_vcn.vcn_id
}

output "cls1_private_sub_1_id" {
  value = module.cls1_vcn.subnet_all_attributes.private_sub1.id
}

output "cls1_private_sub_2_id" {
  value = module.cls1_vcn.subnet_all_attributes.private_sub2.id
}

output "cls1_public_sub_1_id" {
  value = module.cls1_vcn.subnet_all_attributes.public_sub1.id
}

output "cls2_private_sub_1_id" {
  value = module.cls2_vcn.subnet_all_attributes.private_sub1.id
}

output "cls2_private_sub_2_id" {
  value = module.cls2_vcn.subnet_all_attributes.private_sub2.id
}

output "cls2_public_sub_1_id" {
  value = module.cls2_vcn.subnet_all_attributes.public_sub1.id
}