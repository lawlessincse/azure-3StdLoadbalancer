resource "azurerm_lb" "R18_EUSPRODSLB" {
  location            = azurerm_resource_group.R1_EUSPRODRG.location
  name                = "EUSPRODSLB"
  resource_group_name = azurerm_resource_group.R1_EUSPRODRG.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name = "EUSPRODSLB-FEPIP"
    public_ip_address_id = azurerm_public_ip.R10_EUSPRODSLB-PIP.id
  }
}

resource "azurerm_lb_backend_address_pool" "R19_PRODBP1" {
  loadbalancer_id = azurerm_lb.R18_EUSPRODSLB.id
  name            = "PRODBP1"
}

resource "azurerm_lb_probe" "R20_http" {
  loadbalancer_id = azurerm_lb.R18_EUSPRODSLB.id
  name            = "http"
  port            = 80
  interval_in_seconds = "5"
}

resource "azurerm_lb_rule" "R21_BERULE1" {
  backend_port                   = 80
  frontend_ip_configuration_name = "EUSPRODSLB-FEPIP"
  frontend_port                  = 80
  loadbalancer_id                = azurerm_lb.R18_EUSPRODSLB.id
  name                           = "BERULE1"
  protocol                       = "Tcp"
  probe_id = azurerm_lb_probe.R20_http.id
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.R19_PRODBP1.id]
}

resource "azurerm_network_interface_backend_address_pool_association" "R22_ASS1" {
  backend_address_pool_id = azurerm_lb_backend_address_pool.R19_PRODBP1.id
  ip_configuration_name   = "EUSPRODWEBVM1-NIC-CONFIG"
  network_interface_id    = azurerm_network_interface.R11_EUSPRODWEBVM1-NIC.id
}

resource "azurerm_network_interface_backend_address_pool_association" "R23_ASS2" {
  backend_address_pool_id = azurerm_lb_backend_address_pool.R19_PRODBP1.id
  ip_configuration_name   = "EUSPRODWEBVM2-NIC-CONFIG"
  network_interface_id    = azurerm_network_interface.R13_EUSPRODWEBVM2-NIC.id
}
