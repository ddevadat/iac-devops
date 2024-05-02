locals {
  cls1_nat_gateway_route_rules = [
    {
      destination       = var.cls2_vcn_cidr # Route Rule Destination CIDR
      destination_type  = "CIDR_BLOCK"     # only CIDR_BLOCK is supported at the moment
      network_entity_id = "drg"            # for nat_gateway_route_rules input variable, you can use special strings "drg", "nat_gateway" or pass a valid OCID using string or any Named Values
      description       = "Terraformed - User added Routing Rule: To drg provided to this module. drg_id, if available, is automatically retrieved with keyword drg"
    }
  ]

  cls2_nat_gateway_route_rules = [
    {
      destination       = var.cls1_vcn_cidr # Route Rule Destination CIDR
      destination_type  = "CIDR_BLOCK"     # only CIDR_BLOCK is supported at the moment
      network_entity_id = "drg"            # for nat_gateway_route_rules input variable, you can use special strings "drg", "nat_gateway" or pass a valid OCID using string or any Named Values
      description       = "Terraformed - User added Routing Rule: To drg provided to this module. drg_id, if available, is automatically retrieved with keyword drg"
    }
  ]
}

locals {
  ads                   = slice(data.oci_identity_availability_domains.ads.availability_domains, 0, var.ad_count)
  public_subnets_list   = ["public-subnet","oke-control-plane"]
  private_subnets_list  = ["private-subnet"]

  cls1_network_cidr_blocks = {
    for idx, subnet in concat(local.public_subnets_list, local.private_subnets_list) : subnet =>
        (subnet == "oke-control-plane") ? cidrsubnet(var.cls1_vcn_cidr,12,0):cidrsubnet(var.cls1_vcn_cidr,8,idx+1)
    }

  cls2_network_cidr_blocks = {
    for idx, subnet in concat(local.public_subnets_list, local.private_subnets_list) : subnet =>
        (subnet == "oke-control-plane") ? cidrsubnet(var.cls2_vcn_cidr,12,0):cidrsubnet(var.cls2_vcn_cidr,8,idx+1)
    }

  cls1_public_subnet_cidrs   = [for subnet_name in local.public_subnets_list : local.cls1_network_cidr_blocks[subnet_name]]
  cls1_private_subnet_cidrs  = [for subnet_name in local.private_subnets_list : local.cls1_network_cidr_blocks[subnet_name]]

  cls2_public_subnet_cidrs   = [for subnet_name in local.public_subnets_list : local.cls2_network_cidr_blocks[subnet_name]]
  cls2_private_subnet_cidrs  = [for subnet_name in local.private_subnets_list : local.cls2_network_cidr_blocks[subnet_name]]


  cls1_public_subnets = { for idx, name in local.public_subnets_list : "public_sub${idx + 1}" => {
    name       = name
    cidr_block = local.cls1_public_subnet_cidrs[idx]
    type       = "public"
    dns_label  = (name == "oke-control-plane")? "okectrp": "public"
  } }
  cls1_private_subnets = { for idx, name in local.private_subnets_list : "private_sub${idx + 1}" => {
    name       = name
    cidr_block = local.cls1_private_subnet_cidrs[idx]
    type       = "private"
    dns_label  = (name == "oke-control-plane")? "okectrp": "private"
  } }

  cls2_public_subnets = { for idx, name in local.public_subnets_list : "public_sub${idx + 1}" => {
    name       = name
    cidr_block = local.cls2_public_subnet_cidrs[idx]
    type       = "public"
    dns_label  = (name == "oke-control-plane")? "okectrp": "public"
  } }
  cls2_private_subnets = { for idx, name in local.private_subnets_list : "private_sub${idx + 1}" => {
    name       = name
    cidr_block = local.cls2_private_subnet_cidrs[idx]
    type       = "private"
    dns_label  = (name == "oke-control-plane")? "okectrp": "private"
  } }

  cls1_subnet_maps                  = merge(local.cls1_public_subnets, local.cls1_private_subnets)
  cls2_subnet_maps                  = merge(local.cls2_public_subnets, local.cls2_private_subnets)

  # public_subnet_id             = lookup(module.vcn.subnet_id, "public-subnet", null)
  # ssh_keys                     = []

}
