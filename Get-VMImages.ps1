# The following cmdlets are related to each other
# Get-VMImagePublishers
# Get-VMImages
# Get-VMImageSkus

param (
    [string]$PublisherName="MicrosoftWindowsServer"
    )

################################################################################
# Import modules
Import-Module AzureRM

################################################################################
# Import preferences

. .\secure-content\azure-preferences.ps1

################################################################################
# Main script

Get-AzureRmVMImageOffer -Location $location -PublisherName $PublisherName | Select-Object Offer, PublisherName, Location