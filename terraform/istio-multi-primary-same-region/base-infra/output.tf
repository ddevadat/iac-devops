output "cls1_vcn_id" {
  value = module.cls1_vcn.vcn_id
}

output "cls2_vcn_id" {
  value = module.cls1_vcn.vcn_id
}

output "cls1_vcn_cidr" {
  value = var.cls1_vcn_cidr
}

output "cls2_vcn_cidr" {
  value = var.cls1_vcn_cidr
}


####
output "cls1_private_sub_1_id" {
  value = module.cls1_vcn.subnet_all_attributes.private_sub1.id
}

output "cls1_public_sub_1_id" {
  value = module.cls1_vcn.subnet_all_attributes.public_sub1.id
}

output "cls1_public_sub_2_id" {
  value = module.cls1_vcn.subnet_all_attributes.public_sub2.id
}

####
output "cls2_private_sub_1_id" {
  value = module.cls1_vcn.subnet_all_attributes.private_sub1.id
}

output "cls2_public_sub_1_id" {
  value = module.cls1_vcn.subnet_all_attributes.public_sub1.id
}

output "cls2_public_sub_2_id" {
  value = module.cls1_vcn.subnet_all_attributes.public_sub2.id
}

###

output "cls1_private_sub_1_cidr_block" {
  value = module.cls1_vcn.subnet_all_attributes.private_sub1.cidr_block
}

output "cls1_public_sub_1_cidr_block" {
  value = module.cls1_vcn.subnet_all_attributes.public_sub1.cidr_block
}

output "cls1_public_sub_2_cidr_block" {
  value = module.cls1_vcn.subnet_all_attributes.public_sub2.cidr_block
}

###

output "cls2_private_sub_1_cidr_block" {
  value = module.cls1_vcn.subnet_all_attributes.private_sub1.cidr_block
}

output "cls2_public_sub_1_cidr_block" {
  value = module.cls1_vcn.subnet_all_attributes.public_sub1.cidr_block
}

output "cls2_public_sub_2_cidr_block" {
  value = module.cls1_vcn.subnet_all_attributes.public_sub2.cidr_block
}