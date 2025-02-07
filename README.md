# Azure Managed Grafana
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/claranet/managed-grafana/azurerm/)

Azure module to deploy a [Azure Managed Grafana](https://learn.microsoft.com/en-us/azure/managed-grafana/overview).

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | OpenTofu version | AzureRM version |
| -------------- | ----------------- | ---------------- | --------------- |
| >= 8.x.x       | **Unverified**    | 1.8.x            | >= 4.0          |
| >= 7.x.x       | 1.3.x             |                  | >= 3.0          |
| >= 6.x.x       | 1.x               |                  | >= 3.0          |
| >= 5.x.x       | 0.15.x            |                  | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   |                  | >= 2.0          |
| >= 3.x.x       | 0.12.x            |                  | >= 2.0          |
| >= 2.x.x       | 0.12.x            |                  | < 2.0           |
| <  2.x.x       | 0.11.x            |                  | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

⚠️ Since modules version v8.0.0, we do not maintain/check anymore the compatibility with
[Hashicorp Terraform](https://github.com/hashicorp/terraform/). Instead, we recommend to use [OpenTofu](https://github.com/opentofu/opentofu/).

```hcl
data "azuread_group" "admin" {
  display_name     = "Contoso Admins"
  security_enabled = true
}

module "managed_grafana" {
  source  = "claranet/managed-grafana/azurerm"
  version = "x.x.x"

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.name

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  grafana_major_version = 10
  api_key_enabled       = true

  grafana_admin_role_object_ids = {
    "Contoso Admin Group" = data.azuread_group.admin.object_id
  }

  logs_destinations_ids = [
    module.run.logs_storage_account_id,
    module.run.log_analytics_workspace_id
  ]

  extra_tags = {
    foo = "bar"
  }
}
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.2.28 |
| azurerm | ~> 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| diagnostics | claranet/diagnostic-settings/azurerm | ~> 8.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_dashboard_grafana.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dashboard_grafana) | resource |
| [azurerm_role_assignment.grafana_role_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.grafana_role_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.grafana_role_viewer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurecaf_name.managed_grafana](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api\_key\_enabled | Enable API key for Grafana. | `bool` | `false` | no |
| auto\_generated\_domain\_name\_label\_scope | The scope of the auto-generated domain name label. | `string` | `"TenantReuse"` | no |
| azure\_monitor\_workspace\_id | The Azure Monitor workspace ID for Grafana integration. | `string` | `null` | no |
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| custom\_name | Custom Azure Managed Grafana, generated if not set. | `string` | `""` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| deterministic\_outbound\_ip\_enabled | Enable deterministic outbound IP for Grafana. | `bool` | `true` | no |
| diagnostic\_settings\_custom\_name | Custom name of the diagnostics settings, name will be `default` if not set. | `string` | `"default"` | no |
| environment | Project environment. | `string` | n/a | yes |
| extra\_tags | Additional tags to add on resources. | `map(string)` | `{}` | no |
| grafana\_admin\_role\_object\_ids | Map of object names => IDs for Grafana Admin role. | `map(string)` | `{}` | no |
| grafana\_contributor\_role\_object\_ids | Map of object names => IDs for Grafana Contributor role. | `map(string)` | `{}` | no |
| grafana\_major\_version | The major version of Grafana to deploy. | `number` | `10` | no |
| grafana\_viewer\_role\_object\_ids | Map of object names => IDs for Grafana Viewer role. | `map(string)` | `{}` | no |
| identity | Identity block information. | <pre>object({<br/>    type         = optional(string, "SystemAssigned")<br/>    identity_ids = optional(list(string))<br/>  })</pre> | `{}` | no |
| location | Azure region to use. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br/>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br/>If you want to use Azure EventHub as a destination, you must provide a formatted string containing both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the <code>&#124;</code> character. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| name\_prefix | Optional prefix for the generated name. | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name. | `string` | `""` | no |
| public\_network\_access\_enabled | Whether the Azure Managed Grafana is available from public network. | `bool` | `false` | no |
| resource\_group\_name | Name of the resource group. | `string` | n/a | yes |
| sku | The SKU of the Grafana. | `string` | `"Standard"` | no |
| smtp | SMTP configuration for Grafana. | <pre>object({<br/>    enabled                   = bool<br/>    host                      = optional(string)<br/>    user                      = optional(string)<br/>    password                  = optional(string)<br/>    start_tls_policy          = optional(string)<br/>    from_address              = optional(string)<br/>    from_name                 = optional(string, "Azure Managed Grafana Notification")<br/>    verification_skip_enabled = optional(bool, false)<br/>  })</pre> | `null` | no |
| stack | Project stack name. | `string` | n/a | yes |
| zone\_redundancy\_enabled | Enable zone redundant for Grafana. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Azure Managed Grafana ID. |
| identity\_principal\_id | Azure Managed Grafana system identity principal ID. |
| module\_diagnostics | Diagnostics settings module outputs. |
| name | Azure Managed Grafana name. |
| resource | Azure Managed Grafana output object. |
<!-- END_TF_DOCS -->

## Related documentation

Microsoft Azure documentation: [Azure Managed Grafana documentation](https://learn.microsoft.com/en-us/azure/managed-grafana/).
