output "dashboard_grafana" {
  description = "Azure Managed Grafana output object"
  value       = azurerm_dashboard_grafana.this
}

output "id" {
  description = "Azure Managed Grafana ID"
  value       = azurerm_dashboard_grafana.this.id
}

output "name" {
  description = "Azure Managed Grafana name"
  value       = azurerm_dashboard_grafana.this.name
}

output "identity_principal_id" {
  description = "Azure Managed Grafana system identity principal ID"
  value       = try(azurerm_dashboard_grafana.this.identity[0].principal_id, null)
}
