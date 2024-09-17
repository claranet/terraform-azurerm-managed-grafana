resource "azurerm_role_assignment" "grafana_role_viewer" {
  for_each = var.grafana_viewer_role_object_ids

  scope                = azurerm_dashboard_grafana.main.id
  principal_id         = each.value
  role_definition_name = "Grafana Viewer"
}

resource "azurerm_role_assignment" "grafana_role_contributor" {
  for_each = var.grafana_contributor_role_object_ids

  scope                = azurerm_dashboard_grafana.main.id
  principal_id         = each.value
  role_definition_name = "Grafana Contributor"
}

resource "azurerm_role_assignment" "grafana_role_admin" {
  for_each = var.grafana_admin_role_object_ids

  scope                = azurerm_dashboard_grafana.main.id
  principal_id         = each.value
  role_definition_name = "Grafana Admin"
}
