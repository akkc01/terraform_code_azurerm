# output "fvm_pip" {
#   value = "Frontend_VM IP address is- ${module.pip.fvm_pip}, You can Access using ssh Only."

# }

# output "bvm_pip" {
#   value = "Backend_VM IP address is- ${module.pip.bvm_pip}, You can Access using ssh Only."
# }

output "fvm_private_ip_address" {
  value = "Frontend_VM Private IP address is- ${module.nic.fvm_private_ip}, You can Access using Azure Bastion Only."
}

output "bvm_private_ip_address" {
   value = "Backend_VM Private IP address is- ${module.nic.bvm_private_ip}, You can Access using Azure Bastion Only."
}

output "bastion_pip" {
  value = "Bastion Public IP address is- ${module.pip.bastion_pip}, You can Access using Bastion Only."
}

output "Sql_server_name" {
  value = "SQL_Server Name is- ${module.mssql_server.sql_server_name}, You can Use this for String Connection."
}

output "Sql_db1" {
  value = "SQL_db1 Name is- ${module.mssql_db.sql_db1_name}, You can Use this for String Connection."
}

output "Sql_db2" {
  value = "SQL_db2 Name is- ${module.mssql_db.sql_db2_name}, You can Use this for String Connection."
}

