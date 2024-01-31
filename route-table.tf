resource "azurerm_route_table" "route_table_spoke" {
  name                          = "${var.prefix}-Route-Table-Spoke"
  location                      = azurerm_resource_group.main_rg.location
  resource_group_name           = azurerm_resource_group.main_rg.name
  disable_bgp_route_propagation = true
}

resource "azurerm_route" "spoke_to_hub" {
  name                   = "${var.prefix}-Route-To-Hub"
  resource_group_name    = azurerm_resource_group.main_rg.name
  route_table_name       = azurerm_route_table.route_table_spoke.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.1.4"
}

resource "azurerm_subnet_route_table_association" "route_tb_subnet_association" {
  subnet_id      = azurerm_subnet.subnet_workload.id
  route_table_id = azurerm_route_table.route_table_spoke.id
}
