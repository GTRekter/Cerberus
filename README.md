# Cerberus
This script leverages the mapping provided by the Microsoft aztfexport tool and the new Terraform config-driven import workflow to generate the Terraform code for an entire Azure subscription with a single execution.

## Requirement
This script needs access to Azure. To provide this access, users must have Azure CLI installed on their local machine. Once installed, users will need to authenticate to Azure using the following command:
```
az login
```

## Sample
The following is an example of an export. As you can observe, the script is currently not capable of distinguishing the type of VM and then using the correct Terraform type. However, it lists all of them in the output and comments out the import block. This approach allows the generation process to proceed.
```
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.61.0"
    }
  }
}
provider "azurerm" {
  features {}
}
import {
  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/NetworkWatcherRG/providers/Microsoft.Network/networkWatchers/NetworkWatcher_uksouth"
  to = azurerm_network_watcher.NetworkWatcher_uksouth
}
import {
  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/RG-TRAINING-SWARM-UKS-01/providers/Microsoft.Compute/disks/osdisk-uks-01"
  to = azurerm_managed_disk.osdisk-uks-01
}
import {
  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/RG-TRAINING-SWARM-UKS-01/providers/Microsoft.Compute/disks/osdisk-uks-02"
  to = azurerm_managed_disk.osdisk-uks-02
}
# Multiple matching entries found for resource:
# Resource Type: Microsoft.Compute/virtualMachines
# Resource ID: /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-swarm-uks-01/providers/Microsoft.Compute/virtualMachines/vm-uks-01
# ---
#import {
#  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-swarm-uks-01/providers/Microsoft.Compute/virtualMachines/vm-uks-01"
#  to = azurerm_linux_virtual_machine azurerm_virtual_machine azurerm_windows_virtual_machine.vm-uks-01
#}
# No matching entry found for resource:
# Resource Type: Microsoft.Compute/virtualMachines/extensions
# Resource ID: /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-swarm-uks-01/providers/Microsoft.Compute/virtualMachines/vm-uks-01/extensions/enablevmaccess
# ---
# Multiple matching entries found for resource:
# Resource Type: Microsoft.Compute/virtualMachines
# Resource ID: /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-swarm-uks-01/providers/Microsoft.Compute/virtualMachines/vm-uks-02
# ---
#import {
#  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-swarm-uks-01/providers/Microsoft.Compute/virtualMachines/vm-uks-02"
#  to = azurerm_linux_virtual_machine azurerm_virtual_machine azurerm_windows_virtual_machine.vm-uks-02
#}
import {
  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-swarm-uks-01/providers/Microsoft.Network/networkInterfaces/nic-uks-01"
  to = azurerm_network_interface.nic-uks-01
}
import {
  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-swarm-uks-01/providers/Microsoft.Network/networkInterfaces/nic-uks-02"
  to = azurerm_network_interface.nic-uks-02
}
import {
  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-swarm-uks-01/providers/Microsoft.Network/publicIPAddresses/pip-uks-01"
  to = azurerm_public_ip.pip-uks-01
}
import {
  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-swarm-uks-01/providers/Microsoft.Network/publicIPAddresses/pip-uks-02"
  to = azurerm_public_ip.pip-uks-02
}
import {
  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-swarm-uks-01/providers/Microsoft.Network/virtualNetworks/vnet-training-swarm-uks-01"
  to = azurerm_virtual_network.vnet-training-swarm-uks-01
}
import {
  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/RG-TRAINING-SWARM-USW-01/providers/Microsoft.Compute/disks/osdisk-usw-01"
  to = azurerm_managed_disk.osdisk-usw-01
}
import {
  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/RG-TRAINING-SWARM-USW-01/providers/Microsoft.Compute/disks/osdisk-usw-02"
  to = azurerm_managed_disk.osdisk-usw-02
}
# Multiple matching entries found for resource:
# Resource Type: Microsoft.Compute/virtualMachines
# Resource ID: /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-swarm-usw-01/providers/Microsoft.Compute/virtualMachines/vm-usw-01
# ---
#import {
#  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-swarm-usw-01/providers/Microsoft.Compute/virtualMachines/vm-usw-01"
#  to = azurerm_linux_virtual_machine azurerm_virtual_machine azurerm_windows_virtual_machine.vm-usw-01
#}
# Multiple matching entries found for resource:
# Resource Type: Microsoft.Compute/virtualMachines
# Resource ID: /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-swarm-usw-01/providers/Microsoft.Compute/virtualMachines/vm-usw-02
# ---
#import {
#  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-swarm-usw-01/providers/Microsoft.Compute/virtualMachines/vm-usw-02"
#  to = azurerm_linux_virtual_machine azurerm_virtual_machine azurerm_windows_virtual_machine.vm-usw-02
#}
import {
  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-swarm-usw-01/providers/Microsoft.Network/networkInterfaces/nic-usw-01"
  to = azurerm_network_interface.nic-usw-01
}
import {
  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-swarm-usw-01/providers/Microsoft.Network/networkInterfaces/nic-usw-02"
  to = azurerm_network_interface.nic-usw-02
}
import {
  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-swarm-usw-01/providers/Microsoft.Network/publicIPAddresses/pip-usw-01"
  to = azurerm_public_ip.pip-usw-01
}
import {
  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-swarm-usw-01/providers/Microsoft.Network/publicIPAddresses/pip-usw-02"
  to = azurerm_public_ip.pip-usw-02
}
import {
  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-swarm-usw-01/providers/Microsoft.Network/virtualNetworks/vnet-training-swarm-usw-01"
  to = azurerm_virtual_network.vnet-training-swarm-usw-01
}
import {
  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-uks/providers/Microsoft.Network/publicIPAddresses/pip-training-uks-01"
  to = azurerm_public_ip.pip-training-uks-01
}
import {
  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-uks/providers/Microsoft.Network/virtualNetworkGateways/vng-training-uks-01"
  to = azurerm_virtual_network_gateway.vng-training-uks-01
}
import {
  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-training-uks/providers/Microsoft.Network/virtualNetworks/vnet-training-uks-01"
  to = azurerm_virtual_network.vnet-training-uks-01
}
import {
  id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/sample_group/providers/Microsoft.ContainerRegistry/registries/samplecontainerazdo"
  to = azurerm_container_registry.samplecontainerazdo
}
```

# References
- **aztfexport:** https://github.com/Azure/aztfexport
- **aztft:** https://github.com/magodo/aztft
