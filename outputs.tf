output "resource" {
  description = "Azure Managed Grafana output object."
  value       = azurerm_dashboard_grafana.main
}

output "id" {
  description = "Azure Managed Grafana ID."
  value       = azurerm_dashboard_grafana.main.id
}

output "name" {
  description = "Azure Managed Grafana name."
  value       = azurerm_dashboard_grafana.main.name
}

output "identity_principal_id" {
  description = "Azure Managed Grafana system identity principal ID."
  value       = try(azurerm_dashboard_grafana.main.identity[0].principal_id, null)
}

output "module_diagnostics" {
  description = "Diagnostics settings module outputs."
  value       = module.diagnostics
}
