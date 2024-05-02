resource "oci_core_network_security_group_security_rule" "cls1_egress_pods" {
  network_security_group_id = module.oke_cluster1.pod_nsg_id
  direction                 = "EGRESS"
  protocol                  = "all"
  destination               = var.cls2_vcn_cidr
  description               = "Cross Cluster Communication"
  destination_type          = "CIDR_BLOCK"
  provider                  = oci.region_1
}

resource "oci_core_network_security_group_security_rule" "cls1_ingress_pods" {
  network_security_group_id = module.oke_cluster1.pod_nsg_id
  direction                 = "INGRESS"
  description               = "Cross Cluster Communication"
  protocol                  = "all"
  source                    = var.cls2_vcn_cidr
  source_type               = "CIDR_BLOCK"
  provider                  = oci.region_1
}

####


resource "oci_core_network_security_group_security_rule" "cls2_egress_pods" {
  network_security_group_id = module.oke_cluster2.pod_nsg_id
  direction                 = "EGRESS"
  protocol                  = "all"
  destination               = var.cls1_vcn_cidr
  description               = "Cross Cluster Communication"
  destination_type          = "CIDR_BLOCK"
  provider                  = oci.region_2
}

resource "oci_core_network_security_group_security_rule" "cls2_ingress_pods" {
  network_security_group_id = module.oke_cluster2.pod_nsg_id
  direction                 = "INGRESS"
  description               = "Cross Cluster Communication"
  protocol                  = "all"
  source                    = var.cls1_vcn_cidr
  source_type               = "CIDR_BLOCK"
  provider                  = oci.region_2
}