param (
    [string]$pcName="crucia"
    )


################################################################################
# Import modules

Import-Module AzureRM

################################################################################
# Setup Azure credentials 

$username   = "zhixian@telara.onmicrosoft.com"
$password   = Get-Content "C:\Users\Zhi Xian\Google Drive\Emp\Zhixian\research\powershell\azure\telara.onmicrosoft.com.secure" | ConvertTo-SecureString
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password

################################################################################
# Connect to Azure

Connect-AzureRmAccount -Credential $credential -TenantId "17370574-7110-40c3-a317-12ac3ebf9e96"


################################################################################
# Constants

Set-Variable resourceGroupName -Option Constant -Value "$pcName-resource-group"
Set-Variable locationName -Option Constant -Value "southeastasia"
Set-Variable virtualMachineName -Option Constant -Value "$pcName"
Set-Variable virtualNetworkName -Option Constant -Value "$pcName-vnet"
Set-Variable subnet1Name -Option Constant -Value "$pcName-subnet1"
Set-Variable nsgName -Option Constant -Value "$pcName-nsg"
Set-Variable publicIpName -Option Constant -Value "$pcName-ip"



# INFO: Finding image name
# Get-AzureRmVMImagePublisher -Location "Southeast Asia"
# Get-AzureRmVMImageOffer -Location "Southeast Asia" -PublisherName "MicrosoftWindowsServer"
# Get-AzureRmVMImageSku -Location "Southeast Asia" -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer"

$admin_username   = "zhixian"
$admin_password   = ConvertTo-SecureString "P@ssw0rd290850" -AsPlainText -Force
$admin_credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $admin_username, $admin_password

# Note: When RDP-ing to the box:
# In the Windows Security window, select More choices, and then select Use a different account. 
# Type the username as "localhost\username", enter password you created for the virtual machine, and then click OK.

New-AzureRmVm `
-ResourceGroupName $resourceGroupName `
-Location $locationName `
-Name $virtualMachineName `
-VirtualNetworkName $virtualNetworkName `
-SubnetName $subnet1Name `
-AllocationMethod "Dynamic" `
-SecurityGroupName $nsgName `
-PublicIpAddressName $publicIpName `
-ImageName "MicrosoftWindowsServer:WindowsServer:2016-Datacenter:latest" `
-Credential $admin_credential `
-Size "Standard_B2s" `
-DomainNameLabel $pcName

# Other useful parameters?
# -DataDiskSizeInGb 30                  # what's the default? 128GB
# -Image "Win2016Datacenter"            # default to "Win2016Datacenter"; Other available values are: 2016Datacenter, Win2012R2Datacenter, Win2012Datacenter, Win2008R2SP1, UbuntuLTS, CentOS, CoreOS, Debian, openSUSE-Leap, RHEL, SLES
# -Size "Standard_DS1_v2"               # defaults to Standard_DS1_v2
# -OpenPorts 123,21                     # defaults to Windows: 3389, 5985 and Linux: 22
# -DomainNameLabel "asd"                # {domainNameLabel}.{location}.cloudapp.azure.com
# -Linux                                # Use only if disk file is for a Linux VM
# -SubnetAddressPrefix "192.168.1.0/24" # defaults to 	192.168.1.0/24

# INFO: Find available VM Size/Specifications 
# Get-AzureRmVMSize -Location "Southeast Asia"
#Get-AzureRmVMSize -ResourceGroupName $resourceGroupName -VMName $virtualMachineName



#Resizing VM to save cost (Should use -Size if creating VM; this is useful for upscaling)
#$vm = Get-AzureRmVM -ResourceGroupName $resourceGroupName  -VMName $virtualMachineName
#$vm.HardwareProfile.VmSize = "Standard_D4"
#$vm.HardwareProfile.VmSize = "Standard_B2s"
#Update-AzureRmVM -VM $vm -ResourceGroupName $resourceGroupName



# $disk= Get-AzureRmDisk -ResourceGroupName $rgName -DiskName $vm.StorageProfile.OsDisk.Name
# $disk.DiskSizeGB = 1023
# Update-AzureRmDisk -ResourceGroupName $rgName -Disk $disk -DiskName $disk.Name

# TODO
# How to add additional data disk 
$diskConfig = New-AzureRmDiskConfig -SkuName "StandardSSD_LRS" -Location $locationName -CreateOption Empty -DiskSizeGB 32 -OsType "Windows"
$dataDisk1 = New-AzureRmDisk -ResourceGroupName $resourceGroupName -DiskName "dataDiskF" -Disk $diskConfig 

$vm = Get-AzureRmVM -ResourceGroupName $resourceGroupName  -VMName $virtualMachineName
$vm = Add-AzureRmVMDataDisk -VM $vm -Name "dataDiskF" -CreateOption Attach -ManagedDiskId $dataDisk1.Id -Lun 1
Update-AzureRmVM -ResourceGroupName $resourceGroupName -VM $vm 

# initialize disk
# https://docs.microsoft.com/en-us/azure/virtual-machines/windows/attach-disk-ps

Set-AzureRmVMCustomScriptExtension -ResourceGroupName $resourceGroupName -Location $locationName -VMName $virtualMachineName -Name "initDisk" -TypeHandlerVersion "1.4" -StorageAccountName "hercules1" -StorageAccountKey "Ha99nHXEhvfBLyyDHXEts+m6y5TbEUtazct8oqnA9xGi83INsM5n+5SQf22NdrjKFK64Fn7acEwkBZPg6mar3g==" -FileName "init-disk.ps1" -ContainerName "scripts" -Run "init-disk.ps1"


# Automate installation of applications