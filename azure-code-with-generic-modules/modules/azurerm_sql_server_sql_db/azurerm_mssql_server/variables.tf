variable "sql_servers" {
  description = "Configuration for multiple Azure SQL Servers"
  type = map(object({
    name              = string
    rg_key            = string
    location          = string
    version           = string
    connection_policy = optional(string, "Default")
    # Optional identity block
    identity = optional(object({
      type = string
    }))

    # Optional threat detection policy block
    threat_detection_policy = optional(object({
      state                      = string
      disabled_alerts            = optional(list(string))
      email_account_admins       = optional(bool, false)
      email_addresses            = optional(list(string))
      retention_days             = optional(number)
      storage_account_access_key = optional(string)
      storage_endpoint           = optional(string)
    }))

    tags = optional(map(string))
  }))
}

variable "rg_name" {
  description = "Map of RG names from RG module"
  type        = map(string)
}
