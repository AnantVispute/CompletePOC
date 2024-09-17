provider "azurerm" {
  features {}
  subscription_id = "9c476e8d-846b-4112-b636-d0fc1d8c673f"
}

resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroupPOC369"
  location = "East US"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "myAppServicePlanPOC369"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "myWebAppPOC369"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    linux_fx_version = "DOCKER|myregistry.azurecr.io/myimage:latest"
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    DOCKER_REGISTRY_SERVER_URL          = "https://myregistry.azurecr.io"
    DOCKER_REGISTRY_SERVER_USERNAME     = var.docker_registry_username
    DOCKER_REGISTRY_SERVER_PASSWORD     = var.docker_registry_password
  }
}
