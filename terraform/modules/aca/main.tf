/*
  ACA deployment, with User Identity to pull from a previously deployed ACR and container image
  SEE: For Identity notes: https://stackoverflow.com/questions/77041834/azure-container-apps-and-terraform-issue
*/

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = var.law_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_app_environment" "aca_env" {
  name                       = var.aca_env_name
  location                   = var.location
  resource_group_name        = azurerm_resource_group.rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
}


resource "azurerm_user_assigned_identity" "containerapp" {
  location            = var.location
  name                = "containerappmi"
  resource_group_name =  azurerm_resource_group.rg.name
}

resource "azurerm_role_assignment" "containerapp_acrpull" {
  scope                = var.acr_id # azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.containerapp.principal_id
  # depends_on = [
  #  azurerm_user_assigned_identity.containerapp
  #]
}

resource "azurerm_container_app" "aca" {
  name                         = var.aca_name
  container_app_environment_id = azurerm_container_app_environment.aca_env.id
  resource_group_name          = azurerm_resource_group.rg.name
  revision_mode                = "Single"
 
  template {
    container {
      name   = "app"
      # "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest" : example
      image  = "${var.acr_login_server}/${var.repo_image_name}" 
      cpu = 0.25
      memory = "0.5Gi"
    }
  }

  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.containerapp.id]
  }

  registry {
    server = var.acr_login_server
    identity = azurerm_user_assigned_identity.containerapp.id
  }

  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    target_port                = 80
    transport                  = "auto"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}


