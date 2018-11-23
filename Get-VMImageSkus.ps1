# The following cmdlets are related to each other
# Get-VMImagePublishers
# Get-VMImages
# Get-VMImageSkus

param (
    [string]$PublisherName="MicrosoftWindowsServer",
    [string]$Offer="WindowsServer"
    )

################################################################################
# Import modules
Import-Module AzureRM

################################################################################
# Import preferences

. .\secure-content\azure-preferences.ps1

################################################################################
# Main script

Get-AzureRmVMImageSku -Location $location -PublisherName $PublisherName -Offer $Offer | Select-Object Skus, Offer, PublisherName, Location