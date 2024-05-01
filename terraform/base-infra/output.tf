output "hosts_var_maps" {
  value = {
    ansible_ssh_common_args          = "-o StrictHostKeyChecking=no"
    cls1_vcn_id                      = module.cls1_vcn.vcn_id
    cls2_vcn_id                      = module.cls2_vcn.vcn_id
    cls1_rpc_id                      = oci_core_remote_peering_connection.cls1_remote_peering_connection.id
    cls2_rpc_id                      = oci_core_remote_peering_connection.cls2_remote_peering_connection.id
  }
}