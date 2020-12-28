# Create virtual machine and Accept the agreement for the mgmt-byol for R81
resource "azurerm_marketplace_agreement" "checkpoint" {
  publisher = "checkpoint"
  offer     = "check-point-cg-r81"
  plan      = "mgmt-byol"
}

resource "azurerm_virtual_machine" "chkpmgmt" {
    name                  = "r81mgmt"
    location              = azurerm_resource_group.rg.location
    resource_group_name   = azurerm_resource_group.rg.name
    network_interface_ids = [azurerm_network_interface.mgmtexternal.id]
    primary_network_interface_id = azurerm_network_interface.mgmtexternal.id
    vm_size               = "Standard_D4s_v3"
    
    depends_on = [azurerm_marketplace_agreement.checkpoint]

    storage_os_disk {
        name              = "R81OsDisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    storage_image_reference {
        publisher = "checkpoint"
        offer     = "check-point-cg-r81"
        sku       = "mgmt-byol"
        version   = "latest"
    }

    plan {
        name = "mgmt-byol"
        publisher = "checkpoint"
        product = "check-point-cg-r81"
        }
    os_profile {
        computer_name  = "r81mgmt"
		admin_username = "phil"
        admin_password = "VPN123vpn123!"
        custom_data = file("customdata.sh") 
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    boot_diagnostics {
        enabled = "true"
        storage_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
    }

}
