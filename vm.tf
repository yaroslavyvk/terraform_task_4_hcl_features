
resource "azurerm_virtual_machine" "main" {
  count                 = var.vm_number
  name                  = "${var.prefix}-vm-${count.index + 1}"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.main[local.network_interface_names[count.index]].id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk-${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname-${count.index + 1}"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment   = "staging"
    name          = "vm${count.index}"
    creation_date = formatdate("YYYY-MM-DD", timestamp())
  }
  lifecycle {
    prevent_destroy = true
  }
}
