variable "project_prefix" {
  type        = string
  description = "prefix string put in front of string"
}

variable "project_suffix" {
  type        = string
  description = "prefix string put at the end of string"
}

variable "owner" {
  description = "Azure tag owner email address"
  type        = string
}

variable "ssh_public_key_file" {
  description = "path to ssh public key file"
  type        = string
}

variable "azurerm_vnet_address_space" {
  description = "Azure VNET CIDR block"
  type        = list(string)
}

variable "azurerm_instance_admin_username" {
  type        = string
  description = "Azure VM instance username"
}

variable "azurerm_disable_password_authentication" {
  type        = bool
  description = "Azure VM disable user password authentication"
  default     = true
}

variable "azurerm_region" {
  type = string
}

variable "azurerm_security_group_rules_slo" {
  type = list(object({
    name                         = string
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_range            = string
    destination_port_range       = string
    source_address_prefix        = optional(string)
    source_address_prefixes      = optional(list(string))
    destination_address_prefix   = optional(string)
    destination_address_prefixes = optional(list(string))
  }))
  default = []
}

variable "f5xc_api_p12_file" {
  description = "F5 XC API certificate file"
  type        = string
}

variable "f5xc_api_p12_cert_password" {
  description = "F5 XC API certificate file password"
  type        = string
  default     = ""
}

variable "f5xc_api_url" {
  description = "F5 XC API URL"
  type        = string
}

variable "f5xc_api_token" {
  description = "F5 XC API token"
  type        = string
  default     = ""
}

variable "f5xc_tenant" {
  description = "F5 XC Tenant name"
  type        = string
}

variable "f5xc_namespace" {
  description = "F5 XC namespace name"
  type        = string
  default     = "system"
}

variable "f5xc_cluster_name" {
  description = "F5 XC CE cluster name"
  type        = string
}

variable "f5xc_azure_vnet_slo_subnet_m0" {
  description = "F5 XC CE SLO interface subnet prefix master 0"
  type        = string
}

variable "f5xc_azure_vnet_slo_subnet_m1" {
  description = "F5 XC CE SLO interface subnet prefix master 1"
  type        = string
}

variable "f5xc_azure_vnet_slo_subnet_m2" {
  description = "F5 XC CE SLO interface subnet prefix master 2"
  type        = string
}

variable "f5xc_azure_vnet_slo_subnet_w0" {
  description = "F5 XC CE SLO interface subnet prefix worker 0"
  type        = string
}

variable "f5xc_azure_vnet_slo_subnet_w1" {
  description = "F5 XC CE SLO interface subnet prefix worker 1"
  type        = string
}

variable "f5xc_azure_vnet_slo_subnet_w2" {
  description = "F5 XC CE SLO interface subnet prefix worker 2"
  type        = string
}

variable "f5xc_ce_gateway_type" {
  description = "F5 XC CE gateway type to set single NIC or multi NIC"
  type        = string
  default     = "voltstack_gateway"
}

variable "f5xc_cluster_latitude" {
  description = "F5 XC CE geo latitude"
  type        = number
  default     = -73.935242
}

variable "f5xc_cluster_longitude" {
  description = "F5 XC CE geo longitude"
  type        = number
  default     = 40.730610
}

variable "f5xc_azure_az_m0" {
  type = string
}

variable "f5xc_azure_az_m1" {
  type = string
}

variable "f5xc_azure_az_m2" {
  type = string
}

variable "f5xc_azure_az_w0" {
  type = string
}

variable "f5xc_azure_az_w1" {
  type = string
}

variable "f5xc_azure_az_w2" {
  type = string
}

variable "azure_client_id" {
  type    = string
  default = ""
}

variable "azure_client_secret" {
  type    = string
  default = ""
}

variable "azure_tenant_id" {
  type    = string
  default = ""
}

variable "azure_subscription_id" {
  type    = string
  default = ""
}