data "azuread_group" "admin" {
  display_name     = "Contoso Admins"
  security_enabled = true
}

module "managed_grafana" {
  source  = "claranet/managed-grafana/azurerm"
  version = "x.x.x"

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name

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
