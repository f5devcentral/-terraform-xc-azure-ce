locals {
  custom_tags = {
    Owner         = var.owner
    f5xc-tenant   = var.f5xc_tenant
    f5xc-template = "f5xc_azure_cloud_ce_three_node_appstack_single_nic_new_vnet_new_subnet"
  }
}

module "f5xc_azure_cloud_ce_three_node_appstack_single_nic_new_vnet_new_subnet" {
  source            = "../../modules/f5xc/ce/appstack/azure"
  owner_tag         = var.owner
  is_sensitive      = false
  has_public_ip     = true
  status_check_type = "cert"
  f5xc_tenant       = var.f5xc_tenant
  f5xc_api_url      = var.f5xc_api_url
  f5xc_namespace    = var.f5xc_namespace
  f5xc_api_token    = var.f5xc_api_token
  f5xc_cluster_labels = {}
  f5xc_cluster_nodes = {
    master = {
      m0 = {
        az         = var.f5xc_azure_az_m0
        subnet_slo = var.f5xc_azure_vnet_slo_subnet_m0
      }
      m1 = {
        az         = var.f5xc_azure_az_m1
        subnet_slo = var.f5xc_azure_vnet_slo_subnet_m1
      }
      m2 = {
        az         = var.f5xc_azure_az_m2
        subnet_slo = var.f5xc_azure_vnet_slo_subnet_m2
      }
    }
    worker = {
      w0 = {
        az         = var.f5xc_azure_az_w0
        subnet_slo = var.f5xc_azure_vnet_slo_subnet_w0
      }
      w1 = {
        az         = var.f5xc_azure_az_w1
        subnet_slo = var.f5xc_azure_vnet_slo_subnet_w1
      }
      w2 = {
        az         = var.f5xc_azure_az_w2
        subnet_slo = var.f5xc_azure_vnet_slo_subnet_w2
      }
    }
  }
  f5xc_token_name                         = format("%s-%s-%s", var.project_prefix, var.f5xc_cluster_name, var.project_suffix)
  f5xc_cluster_name                       = format("%s-%s-%s", var.project_prefix, var.f5xc_cluster_name, var.project_suffix)
  f5xc_api_p12_file                       = var.f5xc_api_p12_file
  f5xc_ce_gateway_type                    = var.f5xc_ce_gateway_type
  f5xc_api_p12_cert_password              = var.f5xc_api_p12_cert_password
  azurerm_region                          = var.azurerm_region
  azurerm_client_id                       = var.azure_client_id
  azurerm_tenant_id                       = var.azure_tenant_id
  azurerm_client_secret                   = var.azure_client_secret
  azurerm_subscription_id                 = var.azure_subscription_id
  azurerm_vnet_address_space              = var.azurerm_vnet_address_space
  azurerm_marketplace_version             = "0.9.2"
  azurerm_instance_admin_username         = var.azurerm_instance_admin_username
  azurerm_security_group_rules_slo        = var.azurerm_security_group_rules_slo
  azurerm_disable_password_authentication = var.azurerm_disable_password_authentication
  ssh_public_key                          = file(var.ssh_public_key_file)
  providers = {
    azurerm  = azurerm.default
    volterra = volterra.default
  }
}

output "f5xc_azure_cloud_ce_three_node_appstack_single_nic_new_vnet_new_subnet" {
  value = module.f5xc_azure_cloud_ce_three_node_appstack_single_nic_new_vnet_new_subnet
}