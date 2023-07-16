resource "azurerm_linux_virtual_machine" "R16_EUSPRODWEBVM1" {
  #Need Input
  name                  = "EUSPRODWEBVM1"
  computer_name         = "EUSPRODWEBVM1"
  network_interface_ids = [azurerm_network_interface.R11_EUSPRODWEBVM1-NIC.id]
  os_disk {
    name                 = "EUSPRODWEBVM1_OSDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  zone = "1"

  #Static Inputs
  admin_username                  = "sri"
  disable_password_authentication = false
  admin_password                  = "Welcome@1234"
  location                        = azurerm_resource_group.R1_EUSPRODRG.location
  resource_group_name             = azurerm_resource_group.R1_EUSPRODRG.name
  size                            = "Standard_B2s"
  custom_data                     = filebase64("webserver.sh")
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "R17_EUSPRODWEBVM2" {
  #Need Input
  name                  = "EUSPRODWEBVM2"
  computer_name         = "EUSPRODWEBVM2"
  network_interface_ids = [azurerm_network_interface.R13_EUSPRODWEBVM2-NIC.id]
  os_disk {
    name                 = "EUSPRODWEBVM2_OSDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  zone = "2"

  #Static Inputs
  admin_username                  = "sri"
  disable_password_authentication = false
  admin_password                  = "Welcome@1234"
  location                        = azurerm_resource_group.R1_EUSPRODRG.location
  resource_group_name             = azurerm_resource_group.R1_EUSPRODRG.name
  size                            = "Standard_B2s"
  custom_data                     = filebase64("webserver.sh")
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}