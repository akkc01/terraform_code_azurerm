
output "SUBNETS" {
  value = "Subnet1 : - ${module.subnet.subnet1}, Subnet2 : - ${module.subnet.subnet2}"
}

output "LOAD_BALENCER_Public_IP" {
  value = module.pip.LoadBalencer_PIP
}

output "SQL_SERVER" {
  value = module.sql_server.sql_server_name
}