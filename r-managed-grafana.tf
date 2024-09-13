resource "azurerm_dashboard_grafana" "managed_grafana" {
  name = local.managed_grafana_name

  location            = var.location
  resource_group_name = var.resource_group_name

  tags = merge(local.default_tags, var.extra_tags)
}
