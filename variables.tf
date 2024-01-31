variable "prefix" {
  default = "non-prod"
}

variable "region" {
  type        = string
  description = "Region for deployed resources"
  default     = "Sweden Central"
}

variable "main_rg" {
  type        = string
  description = "Main resource-group for this assignment"
  default     = "Firewall-SNAT-Ports-NATGW"
}

variable "nsg-1" {
  type        = string
  description = "This NSG will be assigned to vm-1"
  default     = "NSG-1"
}

variable "vnet_hub" {
  type = map(object({
    vnet_name            = string
    vnet_cidr            = string
    subnet_firewall_name = string
    subnet_firewall_cidr = string
    subnet_bastion_name  = string
    subnet_bastion_cidr  = string
  }))
  default = {
    hub = {
      vnet_name            = "Vnet-Hub"
      vnet_cidr            = "10.0.0.0/16"
      subnet_firewall_name = "AzureFirewallSubnet"
      subnet_firewall_cidr = "10.0.1.0/24"
      subnet_bastion_name  = "AzureBastionSubnet"
      subnet_bastion_cidr  = "10.0.3.0/27"
    }
  }
}

variable "vnet_spoke" {
  type = map(object({
    vnet_name            = string
    vnet_cidr            = string
    workload_subnet_name = string
    workload_subnet_cidr = string
  }))
  default = {
    spoke = {
      vnet_name            = "Vnet-Spoke"
      vnet_cidr            = "20.0.0.0/16"
      workload_subnet_name = "Workload-Subnet"
      workload_subnet_cidr = "20.0.0.0/24"
    }
  }
}

variable "vm_password" {
  type        = string
  description = "Password for VMs"
  sensitive   = true
}
