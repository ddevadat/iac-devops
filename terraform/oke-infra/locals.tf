locals {
  oke_pod_cidrs     = (lookup(var.k8s_cluster_properties, "cni", "flannel") == "flannel") ? var.flannel_pods_cidr : var.base_infra_private_subnet_cidr_block
  cp_allowed_cidrs  = ["${var.base_infra_private_subnet_cidr_block}", "${var.base_infra_public_subnet_cidr_block}"]
  home_region       = lookup(data.oci_identity_regions.home_region.regions[0], "name")

}

locals {
  k8s_latest_version      = reverse(sort(data.oci_containerengine_cluster_option.oke.kubernetes_versions))[0]
  cni                     = lookup(var.k8s_cluster_properties, "cni", "flannel")
  kubernetes_version      = lookup(var.k8s_cluster_properties, "kubernetes_version", local.k8s_latest_version)
  worker_image_os_version = lookup(var.k8s_cluster_properties, "worker_image_os_version", 7.9)
  worker_shape            = lookup(var.k8s_cluster_properties, "shape", "VM.Standard.E4.Flex")
  worker_ocpu             = lookup(var.k8s_cluster_properties, "ocpus", "2")
  worker_memory           = lookup(var.k8s_cluster_properties, "memory", "16")
  worker_boot_volume_size = lookup(var.k8s_cluster_properties, "boot_volume_size", "50")
  node_pool_size          = lookup(var.k8s_cluster_properties, "node_pool_size", 3)
}

locals {
  worker_pools = {
    np1 = {
      mode   = "node-pool",
      size   = local.node_pool_size,
      shape  = local.worker_shape,
      create = true
    }
  }
}

locals {
  worker_shape_properties = {
    shape            = local.worker_shape
    ocpus            = local.worker_ocpu
    memory           = local.worker_memory
    boot_volume_size = local.worker_boot_volume_size
  }
}



locals {
  oke_subnets = {
    "bastion" = {
      "create" = "never"
      "id"     = var.base_infra_private_subnet_id
      "cidr"   = var.base_infra_private_subnet_cidr_block
    },
    "pub_lb" = {
      "create" = "never"
      "id"     = var.base_infra_public_subnet_id
      "cidr"   = var.base_infra_public_subnet_cidr_block
    },
    "cp" = {
      "create" = "never"
      "id"     = var.base_infra_private_subnet_id
      "cidr"   = var.base_infra_private_subnet_cidr_block
    },
    "int_lb" = {
      "create" = "never"
      "id"     = var.base_infra_private_subnet_id
      "cidr"   = var.base_infra_private_subnet_cidr_block
    },
    "operator" = {
      "create" = "never"
      "id"     = var.base_infra_private_subnet_id
      "cidr"   = var.base_infra_private_subnet_cidr_block
    },
    "pods" = {
      "create" = "never"
      "id"     = var.base_infra_private_subnet_id
      "cidr"   = var.base_infra_private_subnet_cidr_block
    },
    "workers" = {
      "create" = "never"
      "id"     = var.base_infra_private_subnet_id
      "cidr"   = var.base_infra_private_subnet_cidr_block
    }
  }
}

