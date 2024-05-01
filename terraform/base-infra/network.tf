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

  providers = {
    oci      = oci.region_1
  }
}
