## Hub
resource "azurerm_virtual_network" "vnet_hub" {
  name                = "${var.prefix}-${var.vnet_hub["hub"].vnet_name}"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  address_space       = [var.vnet_hub["hub"].vnet_cidr]
  tags = {
    Environment = "Dev"
  }
}

resource "azurerm_subnet" "subnet_bastion" {
  name                 = var.vnet_hub["hub"].subnet_bastion_name
  resource_group_name  = azurerm_resource_group.main_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = [var.vnet_hub["hub"].subnet_bastion_cidr]
}

## Spoke
resource "azurerm_virtual_network" "vnet_spoke" {
  name                = "${var.prefix}-${var.vnet_spoke["spoke"].vnet_name}"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  address_space       = [var.vnet_spoke["spoke"].vnet_cidr]
  tags = {
    Environment = "Dev"
  }
}

resource "azurerm_subnet" "subnet_workload" {
  name                 = var.vnet_spoke["spoke"].workload_subnet_name
  resource_group_name  = azurerm_resource_group.main_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_spoke.name
  address_prefixes     = [var.vnet_spoke["spoke"].workload_subnet_cidr]
}
