resource "azurerm_dashboard_grafana" "main" {
  name     = local.managed_grafana_name
  location = var.location

  resource_group_name = var.resource_group_name

  grafana_major_version   = var.grafana_major_version
  sku                     = var.sku
  zone_redundancy_enabled = var.zone_redundancy_enabled

  api_key_enabled                        = var.api_key_enabled
  public_network_access_enabled          = var.public_network_access_enabled
  deterministic_outbound_ip_enabled      = var.deterministic_outbound_ip_enabled
  auto_generated_domain_name_label_scope = var.auto_generated_domain_name_label_scope

  dynamic "identity" {
    for_each = var.identity[*]
    content {
      type         = var.identity.type
      identity_ids = var.identity.identity_ids
    }
  }

  dynamic "smtp" {
    for_each = var.smtp[*]
    content {
      enabled                   = var.smtp.enabled
      host                      = var.smtp.host
      user                      = var.smtp.user
      password                  = var.smtp.password
      start_tls_policy          = var.smtp.start_tls_policy
      from_address              = var.smtp.from_address
      from_name                 = var.smtp.from_name
      verification_skip_enabled = var.smtp.verification_skip_enabled
    }
  }

  dynamic "azure_monitor_workspace_integrations" {
    for_each = var.azure_monitor_workspace_id[*]
    content {
      resource_id = var.azure_monitor_workspace_id
    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}
