variable "grafana_major_version" {
  description = "The major version of Grafana to deploy."
  type        = number
  default     = 10
}

variable "identity" {
  description = "Identity block information."
  type = object({
    type         = optional(string, "SystemAssigned")
    identity_ids = optional(list(string))
  })
  default  = {}
  nullable = false
}

variable "api_key_enabled" {
  description = "Enable API key for Grafana."
  type        = bool
  default     = true
}

variable "deterministic_outbound_ip_enabled" {
  description = "Enable deterministic outbound IP for Grafana."
  type        = bool
  default     = true
}

variable "auto_generated_domain_name_label_scope" {
  description = "The scope of the auto-generated domain name label."
  type        = string
  default     = "TenantReuse"
}

variable "smtp" {
  description = "SMTP configuration for Grafana."
  type = object({
    enabled                   = bool
    host                      = optional(string)
    user                      = optional(string)
    password                  = optional(string)
    start_tls_policy          = optional(string)
    from_address              = optional(string)
    from_name                 = optional(string, "Azure Managed Grafana Notification")
    verification_skip_enabled = optional(bool, false)
  })
  default = null
}

variable "sku" {
  description = "The SKU of the Grafana."
  type        = string
  default     = "Standard"
}

variable "zone_redundancy_enabled" {
  description = "Enable zone redundant for Grafana."
  type        = bool
  default     = true
}

variable "azure_monitor_workspace_id" {
  description = "The Azure Monitor workspace ID for Grafana integration."
  type        = string
  default     = null
}

variable "grafana_admin_role_object_ids" {
  description = "Map of object names => IDs for Grafana Admin role."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "grafana_contributor_role_object_ids" {
  description = "Map of object names => IDs for Grafana Contributor role."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "grafana_viewer_role_object_ids" {
  description = "Map of object names => IDs for Grafana Viewer role."
  type        = map(string)
  default     = {}
  nullable    = false
}
