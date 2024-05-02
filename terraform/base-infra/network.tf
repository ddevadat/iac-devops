resource "oci_core_drg" "cls1_drg" {
    compartment_id = var.compartment_id
    display_name = "cls1_drg"
    provider = oci.region_1
}


resource "oci_core_drg" "cls2_drg" {
    compartment_id = var.compartment_id
    display_name = "cls2_drg"
    provider = oci.region_2
}

resource "oci_core_drg_attachment" "cls1_drg_attachment" {
    drg_id = oci_core_drg.cls1_drg.id
    network_details {
        id = module.cls1_vcn.vcn_id
        type = "VCN"
    }
  provider = oci.region_1
}

resource "oci_core_drg_attachment" "cls2_drg_attachment" {
    drg_id = oci_core_drg.cls2_drg.id
    network_details {
        id = module.cls2_vcn.vcn_id
        type = "VCN"
    }
  provider = oci.region_2
}

resource "oci_core_remote_peering_connection" "cls1_remote_peering_connection" {
    compartment_id = var.compartment_id
    drg_id = oci_core_drg.cls1_drg.id
    display_name = "cluster1_to_cluster2"
    provider = oci.region_1
}

resource "oci_core_remote_peering_connection" "cls2_remote_peering_connection" {
    compartment_id = var.compartment_id
    drg_id = oci_core_drg.cls2_drg.id
    display_name = "cluster2_to_cluster1"
    provider = oci.region_2
}

module "cls1_vcn" {
  source                   = "oracle-terraform-modules/vcn/oci"
  version                  = "3.6.0"
  compartment_id           = var.compartment_id
  create_internet_gateway  = true
  create_nat_gateway       = true
  create_service_gateway   = true
  subnets                  = local.cls1_subnet_maps
  vcn_cidrs                = [var.cls1_vcn_cidr]
  vcn_name                 = var.cls1_vcn_name
  lockdown_default_seclist = false
  attached_drg_id          = oci_core_drg.cls1_drg.id

  providers = {
    oci      = oci.region_1
  }
}



module "cls2_vcn" {
  source                   = "oracle-terraform-modules/vcn/oci"
  version                  = "3.6.0"
  compartment_id           = var.compartment_id
  create_internet_gateway  = true
  create_nat_gateway       = true
  create_service_gateway   = true
  subnets                  = local.cls2_subnet_maps
  vcn_cidrs                = [var.cls2_vcn_cidr]
  vcn_name                 = var.cls2_vcn_name
  lockdown_default_seclist = false
  attached_drg_id          = oci_core_drg.cls1_drg.id
  providers = {
    oci      = oci.region_2
  }
}
