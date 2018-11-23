# The following cmdlets are related to each other
# Get-VMImagePublishers
# Get-VMImages
# Get-VMImageSkus

param (
    [string]$locationOpt="southeastasia"
    )

################################################################################
# Import modules
Import-Module AzureRM

################################################################################
# Import preferences

. .\secure-content\azure-preferences.ps1

################################################################################
# Main script

Get-AzureRmVMImagePublisher -Location $location | Select-Object PublisherName, Location