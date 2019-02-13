################################################################################
# Import modules

Import-Module AzureRM

################################################################################
# Setup Azure credentials 

$username   = "zhixian@telara.onmicrosoft.com"
$password   = Get-Content "C:\Users\Zhi Xian\Google Drive\Emp\Zhixian\research\powershell\azure\telara.onmicrosoft.com.secure" | ConvertTo-SecureString
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password


Set-Variable resourceGroupName -Option Constant -Value "meena-bizspark-southeast-asia"
Set-Variable locationName -Option Constant -Value "Southeast Asia"

# Storage account name can contain only lowercase letters and numbers. 
# Name must be between 3 and 24 characters.
# 123456789012345678901234
Set-Variable storageAccountName -Option Constant -Value "meena1"
#Replication option	                            SkuName parameter
#Locally-redundant storage (LRS)	            Standard_LRS (cheapest/poorest)
#Zone-redundant storage (ZRS)	                Standard_ZRS
#Geo-redundant storage (GRS)	                Standard_GRS
#Read-access geo-redundant storage (GRS)	    Standard_RAGRS

Set-Variable virtualNetworkName -Option Constant -Value "meena-bizspark-southeast-asia-vnet"
Set-Variable virtualNetworkAddress -Option Constant -Value "10.0.1.0/24"

Set-Variable publicIpName -Option Constant -Value "meena-ip"

Set-Variable nsgName -Option Constant -Value "meena-nsg"
Set-Variable subnet1Name -Option Constant -Value "subnet1"
Set-Variable subnet1Address -Option Constant -Value "10.0.1.0/24"


Set-Variable meenaNetworkInterface1 -Option Constant -Value "meenaNetworkInterface1" #NIC
Set-Variable meenaIPConfig1 -Option Constant -Value "meenaIPConfig1" 
# AzureRmNetworkInterfaceIpConfig

Set-Variable dns1 -Option Constant -Value "8.8.8.8"
Set-Variable dns2 -Option Constant -Value "8.8.4.4"

Set-Variable virtualMachineName -Option Constant -Value "meena"


################################################################################
# Connect to Azure

Connect-AzureRmAccount -Credential $credential -TenantId "17370574-7110-40c3-a317-12ac3ebf9e96"

################################################################################
# Do work

Write-Host "Creating resource group; skipped"

# $op_success = New-AzureRmResourceGroup -Name "meena-bizspark-southeast-asia" -Location "Southeast Asia"

# $op_success

Write-Host "Creating storage account; skipped"

# $op_success = New-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -Location $locationName -SkuName Standard_LRS -Kind StorageV2 

# $op_success

Write-Host "Creating virtual network; skipped"

# $op_success = New-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Location $locationName -Name $virtualNetworkName -AddressPrefix "10.1.0.0/24"

# $op_success


########################################
# Network security group block

# Write-Host "Creating Network security group; skipped"

# $op_success = New-AzureRmNetworkSecurityGroup -ResourceGroupName $resourceGroupName -Location $locationName -Name $nsgName

# $op_success

# Write-Host "Creating subnet; skipped"
# Write-Host "Creating network interface; skipped"

# Write-Host "Create subnet1"
# $nsg = Get-AzureRmNetworkSecurityGroup -ResourceGroupName $resourceGroupName -Name $nsgName 

# $subnet1 = New-AzureRmVirtualNetworkSubnetConfig -Name $subnet1Name -AddressPrefix $subnet1Address -NetworkSecurityGroup $nsg

# $subnet1

# # It makes no sense to create subnets without some network as context; 
# # The call to New-AzureRmVirtualNetworkSubnetConfig will always work

# Write-Host "vnet"
# $op_success = New-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Location $locationName -Name $virtualNetworkName -AddressPrefix $virtualNetworkAddress -Subnet $subnet1 

# $op_success


########################################
# Network interface block

#Write-Host "Creating public IP; skipped"

# $publicIP = New-AzureRmPublicIpAddress -ResourceGroupName $resourceGroupName -Location $locationName -AllocationMethod Dynamic -Name $publicIpName 

# $publicIP


#Write-Host "Creating network interface; skipped"

# $virtualNetwork = Get-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Name $virtualNetworkName 

# $subnet1 = Get-AzureRmVirtualNetworkSubnetConfig  -VirtualNetwork $virtualNetwork -Name $subnet1Name

# $publicIP = Get-AzureRmPublicIpAddress -ResourceGroupName $resourceGroupName -Name $publicIpName 

# $ipConfig1 = New-AzureRmNetworkInterfaceIpConfig -Name meenaIPConfig1 -Subnet $subnet1 -PublicIpAddress $publicIP -Primary

# $nic1 = New-AzureRmNetworkInterface -ResourceGroupName $resourceGroupName -Location $locationName -Name $meenaNetworkInterface1 -IpConfiguration $ipConfig1 -DnsServer $dns1, $dns2

# $nic1


########################################
# VM block

Write-Host "Creating VM"

New-AzureRmVm `
    -ResourceGroupName $resourceGroupName -Location $locationName -Name $virtualMachineName `
        -VirtualNetworkName $virtualNetworkName `
        -SubnetName $subnet1Name `
        -SecurityGroupName $nsgName `
        -PublicIpAddressName $publicIpName `
        -OpenPorts 80,3389


########################################
# Cleanup code
########################################

#Write-Host "Removing resource group"

#$op_success = Remove-AzureRmResourceGroup -Name "meena2-bizspark-southeast-asia" -Force

#$op_success

# Write-Host "Removing storage account"

# $op_success = Remove-AzureRmStorageAccount -ResourceGroupName $resourceGroupName -AccountName $storageAccountName -Force

# $op_success


# Write-Host "Removing public IP"

# $op_success = Remove-AzureRmPublicIpAddress -ResourceGroupName $resourceGroupName -Name $publicIpName -Force

# $op_success


# Write-Host "Removing network security group"

# $op_success = Remove-AzureRmNetworkSecurityGroup -ResourceGroupName $resourceGroupName -Name $nsgName -Force

# $op_success


#Write-Host "Removing network subnet"

# $op_success = Remove-AzureRmVirtualNetworkSubnetConfig -VirtualNetwork $virtualNetwork Remove-AzureRmVirtualNetworkSubnetConfig -Name $subnet1Name 

# $op_success


# Write-Host "Removing virtual network"

# $op_success = Remove-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Name $virtualNetworkName -Force

# $op_success
