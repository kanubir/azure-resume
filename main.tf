terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.14.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "a12345bc-6789-0d12-e345-6f789ghi0j1k"
  features {}
}

locals {
  app_name = "azure-resume"
  appname  = "azureresume"
}

resource "azurerm_resource_group" "main-rg" {
  name     = "${local.app_name}-rg"
  location = "Canada Central"
}

resource "azurerm_storage_account" "main-st" {
  name                     = "${local.appname}st"
  resource_group_name      = azurerm_resource_group.main-rg.name
  location                 = azurerm_resource_group.main-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_account_static_website" "main-st-sw" {
  storage_account_id = azurerm_storage_account.main-st.id
  error_404_document = "404.html"
  index_document     = "index.html"
}

resource "azurerm_cdn_profile" "main-cdnp" {
  name                = "${local.app_name}-cdnp"
  location            = azurerm_resource_group.main-rg.location
  resource_group_name = azurerm_resource_group.main-rg.name
  sku                 = "Standard_Microsoft"
}

resource "azurerm_cdn_endpoint" "main-cdne" {
  name                          = "${local.app_name}-cdne"
  profile_name                  = azurerm_cdn_profile.main-cdnp.name
  location                      = azurerm_resource_group.main-rg.location
  resource_group_name           = azurerm_resource_group.main-rg.name
  querystring_caching_behaviour = "UseQueryString"

  origin {
    name      = "${local.appname}st-origin"
    host_name = "${local.appname}st.z9.web.core.windows.net"
  }
}

resource "azurerm_cosmosdb_account" "main-cosno" {
  name                = "${local.app_name}-cosno"
  location            = azurerm_resource_group.main-rg.location
  resource_group_name = azurerm_resource_group.main-rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  capabilities {
    name = "EnableServerless"
  }

  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }

  geo_location {
    location          = "canadacentral"
    failover_priority = 0
  }

  backup {
    type                = "Periodic"
    interval_in_minutes = 240
    retention_in_hours  = 8
    storage_redundancy  = "Local"
  }
}

resource "azurerm_storage_account" "main-func-st" {
  name                     = "${local.appname}funcst"
  resource_group_name      = azurerm_resource_group.main-rg.name
  location                 = azurerm_resource_group.main-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "main-asp" {
  name                = "${local.app_name}-asp"
  location            = azurerm_resource_group.main-rg.location
  resource_group_name = azurerm_resource_group.main-rg.name
  os_type             = "Windows"
  sku_name            = "Y1"
}

resource "azurerm_windows_function_app" "main-func" {
  name                = "${local.app_name}-func"
  resource_group_name = azurerm_resource_group.main-rg.name
  location            = azurerm_resource_group.main-rg.location

  storage_account_name       = azurerm_storage_account.main-func-st.name
  storage_account_access_key = azurerm_storage_account.main-func-st.primary_access_key
  service_plan_id            = azurerm_service_plan.main-asp.id

  site_config {
    application_stack {
      dotnet_version              = "v9.0"
      use_dotnet_isolated_runtime = "true"
    }
  }

  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY             = azurerm_application_insights.main-func-appi.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING      = azurerm_application_insights.main-func-appi.connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION = "~2"
  }
}

resource "azurerm_application_insights" "main-func-appi" {
  name                = "${local.app_name}-func-appi"
  location            = azurerm_resource_group.main-rg.location
  resource_group_name = azurerm_resource_group.main-rg.name
  application_type    = "web"
}
