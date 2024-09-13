# Network/firewall variables

variable "public_network_access_enabled" {
  description = "Whether the Azure Managed Grafana is available from public network."
  type        = bool
  default     = false
}
