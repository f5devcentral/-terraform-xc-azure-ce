locals {
  custom_tags = {
    Owner         = var.owner
    f5xc-tenant   = var.f5xc_tenant
    f5xc-template = "f5xc_azure_cloud_ce_single_node_multi_nic_existing_vnet_new_subnet"
  }
}

resource "azurerm_resource_group" "f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet" {
  name     = format("%s-%s-%s", var.project_prefix, "azure-ce-exists-rg", var.project_suffix)
  location = var.azurerm_region
  provider = azurerm.default
}

resource "azurerm_virtual_network" "f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet" {
  name                = format("%s-%s-%s", var.project_prefix, "azure-ce-exists-vnet", var.project_suffix)
  provider            = azurerm.default
  location            = azurerm_resource_group.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet.location
  address_space       = ["172.16.8.0/21"]
  resource_group_name = azurerm_resource_group.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet.name
}

module "f5xc_azure_cloud_ce_single_node_multi_nic_existing_vnet_new_subnet" {
  depends_on        = [azurerm_virtual_network.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet, azurerm_resource_group.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet]
  source            = "../../modules/f5xc/ce/azure"
  owner_tag         = var.owner
  is_sensitive      = false
  has_public_ip     = true
  status_check_type = "cert"
  f5xc_tenant       = var.f5xc_tenant
  f5xc_api_url      = var.f5xc_api_url
  f5xc_namespace    = var.f5xc_namespace
  f5xc_cluster_labels = {}
  f5xc_azure_az_nodes = {
    node0 = {
      az         = var.f5xc_azure_az_node0
      subnet_slo = var.f5xc_azure_vnet_slo_subnet_node0,
      subnet_sli = var.f5xc_azure_vnet_sli_subnet_node0,
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
  azurerm_existing_vnet_name              = azurerm_virtual_network.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet.name
  azurerm_marketplace_version             = "0.9.2"
  azure_security_group_rules_slo          = []
  azure_security_group_rules_sli          = []
  azurerm_instance_admin_username         = var.azurerm_instance_admin_username
  azurerm_existing_resource_group_name    = azurerm_resource_group.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet.name
  azurerm_disable_password_authentication = var.azurerm_disable_password_authentication
  ssh_public_key                          = file(var.ssh_public_key_file)
  providers = {
    azurerm  = azurerm.default
    volterra = volterra.default
  }
}

output "f5xc_azure_cloud_ce_single_node_multi_nic_existing_vnet_new_subnet" {
  value = module.f5xc_azure_cloud_ce_single_node_multi_nic_existing_vnet_new_subnet
}