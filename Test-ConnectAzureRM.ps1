########################################
# Imports
########################################

. ./secure-content/azure-credentials.ps1

########################################
# Main script
########################################

Write-Host "Script to quickly test connectivity to Azure RM"

Write-Host "[START]"

Write-Host "Username is [$username]"
Write-Host "TenantId is [$tenantId]"

Connect-AzureRmAccount -Credential $credential -TenantId $tenantId

Write-Host "[END]"