Import-Module ACMESharp


$vault_path = (Get-ACMEVaultProfile).VaultParameters.RootPath
if (Test-Path $vault_path)
{
    Write-Host "ACMEVault exists; removing vault"
    Remove-Item -Path $vault_path -Force -Recurse
}

Write-Host "Creating ACMEVault"
Initialize-ACMEVault

# There's not EFS on Windows 10 Home, so we need to BypassEFS
# See: https://github.com/ebekker/ACMESharp/issues/203#issuecomment-319558812
# If BypassEFS is not set to true, we will not be able to submit certificates.
if ((Get-ACMEVaultProfile).VaultParameters.ContainsKey("BypassEFS") -ne $true) {
    (Get-ACMEVaultProfile).VaultParameters.Add("BypassEFS", $true)
}
(Get-ACMEVaultProfile).VaultParameters

Write-Host "Adding ACMERegistration"
New-ACMERegistration -Contacts mailto:zhixian@hotmail.com -AcceptTos

Write-Host "Adding ACMEIdentifier(s) - 5"
New-ACMEIdentifier -Dns plato.emptool.com                   -Alias plato_dns
New-ACMEIdentifier -Dns plato-trading-bot.plato.emptool.com -Alias plato_trading_bot_plato_dns
New-ACMEIdentifier -Dns brahman-devops.plato.emptool.com    -Alias brahman_devops_plato_dns
New-ACMEIdentifier -Dns plato-dev-bot.plato.emptool.com     -Alias plato_dev_bot_plato_dns
New-ACMEIdentifier -Dns wordpress.plato.emptool.com         -Alias wordpress_plato_dns
