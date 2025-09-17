
output "SUBNETS1" {
  value = "Subnet1 : - ${module.subnet1.subnet1}, Subnet2 : - ${module.subnet1.subnet2}, AppGwSub : - ${module.subnet1.subnet4}"
}

output "SUBNETS2" {
  value = "Subnet1 : - ${module.subnet2.subnet1}, Subnet2 : - ${module.subnet2.subnet2}, AppGwSub : - ${module.subnet2.subnet4}"
}


output "App_Gateway_Public_IP1" {
  value = module.pip1.appgw_pip
}

output "App_Gateway_Public_IP2" {
  value = module.pip2.appgw_pip
}

output "Traffic_Manager_name" {
  value = module.traffic_mgr.tm_name
}

