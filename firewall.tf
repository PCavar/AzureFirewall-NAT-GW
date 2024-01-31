resource "azurerm_public_ip" "main_firewall_ip" {
  name                = "${var.prefix}-Firewall-PublicIP"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_subnet" "subnet_firewall" {
  name                 = var.vnet_hub["hub"].subnet_firewall_name
  resource_group_name  = azurerm_resource_group.main_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = [var.vnet_hub["hub"].subnet_firewall_cidr]
}


resource "azurerm_firewall" "name" {
  name                = "${var.prefix}-Firewall"
  location            = azurerm_resource_group.main_rg.location
  resource_group_name = azurerm_resource_group.main_rg.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  firewall_policy_id  = azurerm_firewall_policy.azfw_policy.id

  ip_configuration {
    name                 = "${var.prefix}-PublicIP"
    subnet_id            = azurerm_subnet.subnet_firewall.id
    public_ip_address_id = azurerm_public_ip.main_firewall_ip.id
  }
}

resource "azurerm_firewall_policy" "azfw_policy" {
  name                = "Spoke-To-Internet-Policy"
  resource_group_name = azurerm_resource_group.main_rg.name
  location            = azurerm_resource_group.main_rg.location
  sku                 = "Standard"
}

resource "azurerm_firewall_policy_rule_collection_group" "net_policy_rule_collection_group" {
  name               = "DefaultNetworkRuleCollectionGroup"
  firewall_policy_id = azurerm_firewall_policy.azfw_policy.id
  priority           = 200
  network_rule_collection {
    name     = "DefaultNetworkRuleCollection"
    action   = "Allow"
    priority = 100
    rule {
      name                  = "Allow-Web"
      source_addresses      = ["20.0.0.0/24"]
      destination_ports     = ["80", "443"]
      destination_addresses = ["*"]
      protocols             = ["TCP"]
    }
  }
}
