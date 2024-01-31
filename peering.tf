resource "azurerm_virtual_network_peering" "Hub-to-Spoke" {
  name                         = "Peering-Hub-to-Spoke"
  resource_group_name          = azurerm_resource_group.main_rg.name
  virtual_network_name         = azurerm_virtual_network.vnet_hub.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_spoke.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "Spoke-to-Hub" {
  name                         = "Peering-Spoke-to-Hub"
  resource_group_name          = azurerm_resource_group.main_rg.name
  virtual_network_name         = azurerm_virtual_network.vnet_spoke.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}
