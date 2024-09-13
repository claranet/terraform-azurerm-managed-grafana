locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  managed_grafana_name = coalesce(var.custom_name, data.azurecaf_name.managed_grafana.result)
}
