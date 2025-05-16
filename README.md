# Azure Blob Storage File Share App

## 📦 Project Overview
This project provisions an Azure Blob Storage account using Terraform, sets up a lifecycle management policy, and includes a simple HTML + JavaScript front end to upload files directly to the blob container using a SAS token.

## 🛠 Technologies Used
- Azure Blob Storage  
- Terraform (Infrastructure as Code)  
- Azure CLI  
- JavaScript (Browser Fetch API)  
- HTML/CSS (Basic Frontend)

## 🚀 Setup Instructions

1. Clone this repo and navigate to the Terraform folder.

2. Replace placeholders in `main.tf` with your actual Azure subscription and tenant ID:
```hcl
provider "azurerm" {
  features {}
  subscription_id = "<your-subscription-id>"
  tenant_id       = "<your-tenant-id>"
}
```

3. Initialize and apply the Terraform configuration:
```bash
terraform init
terraform apply
```

4. Generate a SAS token with the required permissions:
```bash
az storage container generate-sas --account-name <your-storage-account> \
  --name <your-container-name> --permissions acdlrw --expiry 2025-12-31 \
  --auth-mode login --as-user --output tsv
```

5. Set up CORS to allow your frontend to interact with Azure Blob Storage:
```bash
az storage cors add --methods PUT GET OPTIONS --origins "*" --services b \
  --account-name <your-storage-account> --allowed-headers "*" \
  --exposed-headers "*" --max-age 3600
```

6. Open the `index.html` file in your browser.

7. In `script.js`, replace the placeholder values with your actual values:
```javascript
const storageAccountName = "<your-storage-account>";
const containerName = "<your-container-name>";
const sasToken = "<your-sas-token>";
```

## 📁 File Structure
```
azure-blob-storage-app/
├── terraform/
│   ├── main.tf
├── web/
│   ├── index.html
│   └── script.js
├── README.md
```

## ✅ Key Notes
- Ensure your SAS token includes `w` (write) and `c` (create) permissions.
- CORS must be set for web apps to upload files directly from the browser.
- Always keep your SAS tokens secret and scoped by permissions + expiration.
