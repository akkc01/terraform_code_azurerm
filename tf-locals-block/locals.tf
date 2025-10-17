locals {
  rg_name    = "${var.ajay}-${var.ajay_location}"
  location   = var.ajay_location
  managed_by = "${var.ajay_location}-terraform-${var.ajay}"
  tags = {
    owner       = "maneesh"
    environment = "dev"
    team        = "alpha"
  }
}

locals {
  rg_name1 = "rg-maneesh007"
}