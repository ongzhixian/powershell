################################################################################
# This is a template file that is utilitied by other scripts that require Azure credentials
# $tenantId = A GUID representing the Azure directory (tenant); value is found in Properties of the directory in Azure Portal.
# $username = Some Azure directory administrative user 
# $password = Encrypted password to the holder of the username (See New-EncryptedSecureString.ps1 to generate file)
# $credential = PSCredential use for connecting to Azure RM (Resource Manager)

$tenantId   = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
$username   = "xxxxxxx@xxxxxx.onmicrosoft.com"
$password   = Get-Content "$PSScriptRoot/xxxxxx.onmicrosoft.com.secure" | ConvertTo-SecureString
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password
