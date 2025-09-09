#!! For this all resources I'm going to use for_each-------
# resource "random_password" "vm1_rnd_pass" {
#   length  = 16
#   special = true
# }

# resource "random_password" "vm2_rnd_pass" {
#   length  = 16
#   special = true
# }

# resource "random_password" "sql_rnd_pass" {
#   length  = 16
#   special = true
# }

# resource "random_string" "vm1_rnd_user" {
#   length = 12
#   upper  = true
#   lower  = true
#   numeric = true
# }

# resource "random_string" "vm2_rnd_user" {
#   length = 12
#   upper  = true
#   lower  = true
#   numeric = true
# }

# resource "random_string" "sql_rnd_user" {
#   length = 12
#   upper  = true
#   lower  = true
#   numeric = true
# }

# resource "azurerm_key_vault_secret" "vm1_username" {
#   name         = var.vm1user
#   value        = random_string.vm1_rnd_user.result
#   key_vault_id = data.azurerm_key_vault.kv.id
# }

# resource "azurerm_key_vault_secret" "vm2_username" {
#   name         = var.vm2user
#   value        = random_string.vm2_rnd_user.result
#   key_vault_id = data.azurerm_key_vault.kv.id
# }

# resource "azurerm_key_vault_secret" "vm1_password" {
#   name         = var.vm1pass
#   value        = random_password.vm1_rnd_pass.result
#   key_vault_id = data.azurerm_key_vault.kv.id
# }

# resource "azurerm_key_vault_secret" "vm2_password" {
#   name         = var.vm2pass
#   value        = random_password.vm2_rnd_pass.result
#   key_vault_id = data.azurerm_key_vault.kv.id
# }

# resource "azurerm_key_vault_secret" "sql_username" {
#   name         = var.sql_user
#   value        = random_string.sql_rnd_user.result
#   key_vault_id = data.azurerm_key_vault.kv.id
# }

# resource "azurerm_key_vault_secret" "sql_password" {
#   name         = var.sql_pass
#   value        = random_password.vm_passwords2.result
#   key_vault_id = data.azurerm_key_vault.kv.id
# }

#--------------------------------









resource "random_password" "vm_passwords" {
  for_each = var.vm_secrets

  length           = 16
  min_upper        = 2
  min_lower        = 2
  min_numeric      = 2
  min_special      = 2
  override_special = "!@#$%&*()-_=+"  # Azure-friendly special characters
}

resource "random_string" "vm_usernames" {
  for_each = var.vm_secrets

  length  = 12
  upper   = true
  lower   = true
  numeric = true
}

resource "azurerm_key_vault_secret" "usernames" {
  for_each = var.vm_secrets

  name         = each.value.secret_name
  value        = random_string.vm_usernames[each.key].result
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "passwords" {
  for_each = var.vm_secrets

  name         = each.value.secret_pass
  value        = random_password.vm_passwords[each.key].result
  key_vault_id = data.azurerm_key_vault.kv.id
}
