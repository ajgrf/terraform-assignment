data "azurerm_resource_group" "rg01" {
  name = var.rg_name
}

resource "azurerm_subnet" "example" {
  #count = length(var.subnet_name)
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.rg01.name
  virtual_network_name = var.vnet-name
  address_prefixes     = [var.subnet_CIDR]
  depends_on = [
    azurerm_virtual_network.example
  ]
}

resource "azurerm_virtual_network" "example" {
  name                = var.vnet-name
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.rg01.location
  resource_group_name  = data.azurerm_resource_group.rg01.name
}

output "sub_id" {
  value = azurerm_subnet.example.id
}
