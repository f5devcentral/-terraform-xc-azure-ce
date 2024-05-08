owner                            = "owner_email_address"
project_prefix                   = "f5xc"
project_suffix                   = "80"
ssh_public_key_file              = "path to ssh public key file"
azurerm_vnet_address_space       = ["192.168.0.0/21"]
f5xc_tenant                      = "full f5 xc tenant name e.g. playground-abcdefg"
f5xc_api_url                     = "f5 xc api url e.g. https://https://playground.console.ves.volterra.io/api"
f5xc_cluster_name                = "az-ce-test"
f5xc_api_p12_file                = "path_to_api_cert_file"
f5xc_azure_az_node0              = "1"
azurerm_instance_admin_username  = "operator"
f5xc_azure_vnet_slo_subnet_node0 = "192.168.0.0/26"
f5xc_ce_performance_enhancement_mode = {
  perf_mode_l7_enhanced = false
  perf_mode_l3_enhanced = {
    jumbo_frame_enabled = false
  }
}
f5xc_enable_offline_survivability_mode = false
