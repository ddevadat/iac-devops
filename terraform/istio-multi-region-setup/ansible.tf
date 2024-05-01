
resource "local_sensitive_file" "ansible_inventory" {
  content = templatefile(
    "${path.module}/templates/inventory.yaml.tmpl",
    { 
      local_hosts_var_maps = merge(var.local_hosts_var_maps )
    }

  )
  filename        = "${local.ansible_output_dir}/inventory"
  file_permission = "0600"
}

# resource "local_sensitive_file" "oci_cli_config" {
#   content = templatefile(
#     "${path.module}/templates/oci_cli_config.tmpl",
#     { 
#       local_hosts_var_maps = merge(var.local_hosts_var_maps )
#     }

#   )
#   filename        = "~/.oci/config"
#   file_permission = "0600"
# }

resource "local_sensitive_file" "oci_cli_key_file" {
  content = templatefile(
    "${path.module}/templates/oci_cli_key.tmpl",
    { 
      private_key = var.private_key
    }

  )
  filename        = "${local.ansible_output_dir}/.oci/api.pem"
  file_permission = "0600"
}


resource "null_resource" "run_ansible" {
  provisioner "local-exec" {
    command     = <<-EOT
          ansible-galaxy collection install ${var.ansible_collection_url},${var.ansible_collection_tag}
          # ansible-playbook istio.iac.istio_multi_region_deploy -i ${local_sensitive_file.ansible_inventory.filename}
    EOT
    working_dir = path.module
  }
  triggers = {
    inventory_file_sha_hex = local_sensitive_file.ansible_inventory.id
    ansible_collection_tag = var.ansible_collection_tag
  }
  depends_on = [
    local_sensitive_file.ansible_inventory
  ]
}


# resource "null_resource" "run_ansible_undeploy" {
#   provisioner "local-exec" {
#     when        = destroy
#     command     = <<-EOT
#           echo "Run ansible playbook for Sunbird-RC undeploy"
#           ansible-playbook sunbird_rc.iac.sbrc_undeploy -i ${self.triggers.inventory_file_name}
#     EOT
#     working_dir = path.module
#   }
#   triggers = {
#     ansible_collection_url = var.ansible_collection_url
#     ansible_collection_tag = var.ansible_collection_tag
#     inventory_file_name    = local_sensitive_file.ansible_inventory.filename

#   }
#   depends_on = [
#     local_sensitive_file.ansible_inventory
#   ]
# }

