output "law_id" {
  value = azurerm_log_analytics_workspace.law.id
}

output "aca_env_id" {
  value = azurerm_container_app_environment.aca_env.id
}

output "aca_fqdn" {
  value = azurerm_container_app.aca.latest_revision_fqdn
}

