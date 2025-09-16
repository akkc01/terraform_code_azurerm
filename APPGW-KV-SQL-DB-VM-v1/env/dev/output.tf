
output "SUBNETS" {
  value = "Subnet1 : - ${module.subnet.subnet1}, Subnet2 : - ${module.subnet.subnet2}, AppGwSub : - ${module.subnet.subnet4}"
}

output "App_Gateway_Public_IP" {
  value = module.pip.appgw_pip
}

# output "SQL_SERVER" {
#   value = module.sql_server.sql_server_name
# }