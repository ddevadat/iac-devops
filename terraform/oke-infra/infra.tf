module "oke_cluster1" {
  source                       = "oracle-terraform-modules/oke/oci"
  version                      = "5.1.0"
  compartment_id               = var.compartment_id
  worker_compartment_id        = var.compartment_id
  home_region                  = local.home_region
  region                       = var.region_1
  create_vcn                   = "false"
  vcn_id                       = var.cls1_vcn_id
  subnets                      = local.oke_subnets
  pods_cidr                    = local.oke_pod_cidrs
  cni_type                     = local.cni
  cluster_name                 = "oke_cluster1"
  create_cluster               = true
  kubernetes_version           = local.kubernetes_version
  control_plane_is_public      = true
  create_bastion               = false
  create_operator              = false
  allow_bastion_cluster_access = true
  allow_pod_internet_access    = true
  cluster_freeform_tags        = var.tags
  control_plane_allowed_cidrs  = local.cp_allowed_cidrs
  load_balancers               = "public"
  worker_image_os_version      = local.worker_image_os_version
  worker_shape                 = local.worker_shape_properties
  worker_pools                 = local.worker_pools
  allow_worker_ssh_access      = true
  state_id                     = "cluster1"
  allow_rules_public_lb        = var.k8s_allow_rules_public_lb

  providers = {
    oci      = oci.region_1
    oci.home = oci.home
  }

}

module "oke_cluster2" {
  source                       = "oracle-terraform-modules/oke/oci"
  version                      = "5.1.0"
  compartment_id               = var.compartment_id
  worker_compartment_id        = var.compartment_id
  home_region                  = local.home_region
  region                       = var.region_1
  create_vcn                   = "false"
  vcn_id                       = var.cls2_vcn_id
  subnets                      = local.oke_subnets
  pods_cidr                    = local.oke_pod_cidrs
  cni_type                     = local.cni
  cluster_name                 = "oke_cluster2"
  create_cluster               = true
  kubernetes_version           = local.kubernetes_version
  control_plane_is_public      = true
  create_bastion               = false
  create_operator              = false
  allow_bastion_cluster_access = true
  allow_pod_internet_access    = true
  cluster_freeform_tags        = var.tags
  control_plane_allowed_cidrs  = local.cp_allowed_cidrs
  load_balancers               = "public"
  worker_image_os_version      = local.worker_image_os_version
  worker_shape                 = local.worker_shape_properties
  worker_pools                 = local.worker_pools
  allow_worker_ssh_access      = true
  state_id                     = "cluster2"
  allow_rules_public_lb        = var.k8s_allow_rules_public_lb

  providers = {
    oci      = oci.region_2
    oci.home = oci.home
  }

}