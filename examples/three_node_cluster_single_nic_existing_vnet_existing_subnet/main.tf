locals {
  custom_tags = {
    Owner         = var.owner
    f5xc-tenant   = var.f5xc_tenant
    f5xc-template = "f5xc_azure_cloud_ce_three_node_multi_nic_existing_vnet_new_subnet"
  }
}

resource "azurerm_resource_group" "f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet" {
  location = var.azurerm_region
  name     = format("%s-%s-%s", var.project_prefix, "azure-ce-exists-rg", var.project_suffix)
  provider = azurerm.default
}

resource "azurerm_virtual_network" "f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet" {
  address_space       = ["192.168.0.0/21"]
  name                = format("%s-%s-%s", var.project_prefix, "azure-ce-exists-vnet", var.project_suffix)
  provider            = azurerm.default
  location            = var.azurerm_region
  resource_group_name = azurerm_resource_group.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet.name
}

resource "azurerm_subnet" "slo_node0" {
  name                 = "node0-subnet-slo"
  provider             = azurerm.default
  address_prefixes     = ["192.168.0.0/26"]
  resource_group_name  = azurerm_resource_group.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet.name
  virtual_network_name = azurerm_virtual_network.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet.name
}

resource "azurerm_subnet" "slo_node1" {
  name                 = "node0-subnet-slo"
  provider             = azurerm.default
  address_prefixes     = ["192.168.0.64/26"]
  resource_group_name  = azurerm_resource_group.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet.name
  virtual_network_name = azurerm_virtual_network.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet.name
}

resource "azurerm_subnet" "slo_node2" {
  name                 = "node0-subnet-slo"
  provider             = azurerm.default
  address_prefixes     = ["192.168.0.128/26"]
  resource_group_name  = azurerm_resource_group.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet.name
  virtual_network_name = azurerm_virtual_network.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet.name
}

module "f5xc_azure_cloud_ce_three_node_multi_nic_existing_vnet_new_subnet" {
  depends_on = [
    azurerm_resource_group.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet,
    azurerm_virtual_network.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet, azurerm_subnet.slo_node0, azurerm_subnet.slo_node1, azurerm_subnet.slo_node2
  ]
  source            = "../../modules/f5xc/ce/azure"
  owner_tag         = var.owner
  is_sensitive      = false
  has_public_ip     = true
  status_check_type = "cert"
  f5xc_tenant       = var.f5xc_tenant
  f5xc_api_url      = var.f5xc_api_url
  f5xc_namespace    = var.f5xc_namespace
  f5xc_cluster_labels = {}
  f5xc_cluster_nodes = {
    node0 = {
      az                       = var.f5xc_azure_az_node0
      existing_subnet_name_slo = azurerm_subnet.slo_node0.name
    }
    node1 = {
      az                       = var.f5xc_azure_az_node1
      existing_subnet_name_slo = azurerm_subnet.slo_node1.name
    }
    node2 = {
      az                       = var.f5xc_azure_az_node2
      existing_subnet_name_slo = azurerm_subnet.slo_node2.name
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
  azurerm_instance_admin_username         = var.azurerm_instance_admin_username
  azurerm_existing_resource_group_name    = azurerm_resource_group.f5xc_ce_single_node_multi_nic_existing_rg_existing_vnet.name
  azurerm_disable_password_authentication = var.azurerm_disable_password_authentication
  ssh_public_key                          = file(var.ssh_public_key_file)
  providers = {
    azurerm  = azurerm.default
    volterra = volterra.default
  }
}

output "f5xc_azure_cloud_ce_three_node_multi_nic_existing_vnet_new_subnet" {
  value = module.f5xc_azure_cloud_ce_three_node_multi_nic_existing_vnet_new_subnet
}