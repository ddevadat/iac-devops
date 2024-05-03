
resource "local_sensitive_file" "ansible_inventory" {
  content = templatefile(
    "${path.module}/templates/inventory.yaml.tmpl",
    {
      local_hosts_var_maps = merge(var.local_hosts_var_maps,local.local_scripts_location_map)
    }

  )
  filename        = "${local.ansible_output_dir}/inventory"
  file_permission = "0600"
}

resource "local_sensitive_file" "oci_cli_config" {
  content = templatefile(
    "${path.module}/templates/oci_cli_config.tmpl",
    {
      user_ocid    = var.user_ocid,
      fingerprint  = var.fingerprint,
      tenancy_ocid = var.tenancy_ocid,
      region_1     = var.region_1,
      region_2     = var.region_2

    }

  )
  filename        = pathexpand("~/.oci/config")
  file_permission = "0600"
}

resource "local_sensitive_file" "oci_cli_key_file" {
  content = templatefile(
    "${path.module}/templates/oci_cli_key.tmpl",
    {
      private_key = var.private_key
    }

  )
  filename        = pathexpand("~/.oci/api.pem")
  file_permission = "0600"
}


resource "local_sensitive_file" "cls1_kubeconfig" {
  content = templatefile(
    "${path.module}/templates/cls1_kubeconfig.tmpl",
    {
      cls1_kubeconfig = var.cls1_kubeconfig
    }

  )
  filename        = pathexpand("~/.kube/oke_cluster1")
  file_permission = "0600"
}


resource "local_sensitive_file" "cls2_kubeconfig" {
  content = templatefile(
    "${path.module}/templates/cls2_kubeconfig.tmpl",
    {
      cls2_kubeconfig = var.cls2_kubeconfig
    }

  )
  filename        = pathexpand("~/.kube/oke_cluster2")
  file_permission = "0600"
}

resource "null_resource" "run_ansible" {
  provisioner "local-exec" {
    command     = <<-EOT
          ansible-galaxy collection install ${var.ansible_collection_url},${var.ansible_collection_tag}
          ansible-playbook istio.iac.istio_multi_primary_same_region_deploy -i ${local_sensitive_file.ansible_inventory.filename}
    EOT
    working_dir = path.module
  }
  triggers = {
    inventory_file_sha_hex = local_sensitive_file.ansible_inventory.id
    ansible_collection_tag = var.ansible_collection_tag
  }
  depends_on = [
    local_sensitive_file.ansible_inventory,
    local_sensitive_file.oci_cli_config,
    local_sensitive_file.oci_cli_key_file,
    local_sensitive_file.cls1_kubeconfig,
    local_sensitive_file.cls2_kubeconfig
  ]
}


resource "null_resource" "run_ansible_undeploy" {
  provisioner "local-exec" {
    when        = destroy
    command     = <<-EOT
          ansible-galaxy collection install ${self.triggers.ansible_collection_url},${self.triggers.ansible_collection_tag}
          ansible-playbook istio.iac.istio_multi_primary_same_region_undeploy -i ${self.triggers.inventory_file_name}
    EOT
    working_dir = path.module
  }
  triggers = {
    ansible_collection_url = var.ansible_collection_url
    ansible_collection_tag = var.ansible_collection_tag
    inventory_file_name    = local_sensitive_file.ansible_inventory.filename

  }
  depends_on = [
    local_sensitive_file.ansible_inventory,
    local_sensitive_file.oci_cli_config,
    local_sensitive_file.oci_cli_key_file,
    local_sensitive_file.cls1_kubeconfig,
    local_sensitive_file.cls2_kubeconfig
  ]
}

