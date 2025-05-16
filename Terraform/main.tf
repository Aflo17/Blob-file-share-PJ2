provider "azurerm" {
  features {}
  subscription_id = "<your-subscription-id>"
  tenant_id = "<your-tenant-id>"
  
}

resource "azurerm_resource_group" "rg" {
    name     = "afloresblobapp_rg"
    location = "West US"
}

resource "azurerm_storage_account" "storage" {
    name                     = "afloblobappstorage"
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
  
}

resource "azurerm_storage_container" "container" {
    name                  = "afloresuploads"
    storage_account_id    = azurerm_storage_account.storage.id
    container_access_type = "private"
}

resource "azurerm_storage_management_policy" "policy" {
    storage_account_id = azurerm_storage_account.storage.id

    rule {
        name    = "delete-old-blobs"
        enabled = true

        filters {
            blob_types = ["blockBlob"]
        }

        actions {
            base_blob {
                delete_after_days_since_modification_greater_than = 30 
            }
        }
    }
}

#container_name = "afloresuploads"
#stroage_account_name = "afloblobappstorage"