# Example Single node single NIC new VPC new subnet

This example instantiates:

- Single node CE
- Azure resource group
- Azure linux virtual machine
- Azure virtual_network
- Azure subnet SLO
- Azure network interface SLO
- Azure network security_group SLO
- Azure network interface security group association SLO
- Azure public IP SLO

# Usage

- Export AZURE_CLIENT_ID with: `export TF_VAR_azure_client_id="azure client id"`
- Export AZURE_CLIENT_SECRET with: `export TF_VAR_azure_client_secret="azure client secret"`
- Export AZURE_SUBSCRIPTION_ID with: `export TF_VAR_azure_subscription_id="azure subscription id"`
- Export AZURE_TENANT_ID with: `export TF_VAR_azure_tenant_id="azure tenant id"`
- Export F5 XC API certificate password with:
    * `export VES_P12_PASSWORD="p12 password"`
    * `export TF_VAR_f5xc_api_p12_cert_password="$VES_P12_PASSWORD"`
- Edit `terraform.tfvars` file to align with your environment
- Copy F5XC API certificate file obtained in installation step into example directory
- Initialize with: `terraform init`, optionally run `terraform plan`
- Apply with: `terraform apply -auto-approve` or destroy with: `terraform destroy -auto-approve`