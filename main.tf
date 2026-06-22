# 1. Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.student_name}-final"
  location = var.location
  tags = {
    Project     = "Final"
    StudentName = var.student_name
  }
}

# 2. Azure Container Registry (ACR)
resource "azurerm_container_registry" "acr" {
  name                = "acr${lower(var.student_name)}final"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true

  tags = {
    Project     = "Final"
    StudentName = var.student_name
  }
}

# 3. Azure Kubernetes Service (AKS)
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.student_name}-final"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks-${lower(var.student_name)}"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "standard_b2s_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Project     = "Final"
    StudentName = var.student_name
  }
}

# 4. Attach ACR to AKS (AcrPull Role Assignment)
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}