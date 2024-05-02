output "local_hosts_var_maps" {
  value = {
    ansible_ssh_common_args = "-o StrictHostKeyChecking=no"
    cls1_vcn_id             = var.cls1_vcn_id
    cls2_vcn_id             = var.cls1_vcn_id
    cls1_rpc_id             = var.cls1_rpc_id
    cls2_rpc_id             = var.cls2_rpc_id
    cls1_region_1           = var.region_1
    cls2_region_2           = var.region_2
    compartment_id          = var.compartment_id
    dummy                   = "dummy1"
  }
}

output "cls1_kubeconfig" {
  value = yamlencode(module.oke_cluster1.cluster_kubeconfig)
}

output "cls2_kubeconfig" {
  value = yamlencode(module.oke_cluster2.cluster_kubeconfig)
}