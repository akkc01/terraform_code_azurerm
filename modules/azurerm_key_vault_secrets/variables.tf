variable "kv_name" {}
variable "rg_name" {}
# variable "vm1user" {}
# variable "vm2user" {}
# variable "vm1pass" {}
# variable "vm2pass" {}
# variable "sql_user" {}
# variable "sql_pass" {}

variable "vm_secrets" {
  description = "Map of VM names to secret names"
  type = map(object({
    secret_name = string
    secret_pass = string
  }))
}