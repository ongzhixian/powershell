# Steps executed in PowerShell

Get-Command -Module ActiveDirectory

New-ACMEIdentifier -Dns plato.emptool.com                   -Alias plato_dns
New-ACMEIdentifier -Dns plato-trading-bot.plato.emptool.com -Alias plato_trading_bot_plato
New-ACMEIdentifier -Dns brahman-devops.plato.emptool.com    -Alias brahman_devops_plato
New-ACMEIdentifier -Dns plato-dev-bot.plato.emptool.com     -Alias plato_dev_bot_plato
New-ACMEIdentifier -Dns wordpress.plato.emptool.com         -Alias wordpress_plato

--- 

Complete-ACMEChallenge plato_dns -ChallengeType http-01 -Handler manual

... follow instructions

Submit-ACMEChallenge plato_dns -ChallengeType http-01
(Update-ACMEIdentifier plato_dns -ChallengeType http-01).Challenges | Where-Object {$_.Type -eq "http-01"}
New-ACMECertificate plato_dns -Generate -Alias plato_dns_cert1
Submit-ACMECertificate plato_dns_cert1
Update-ACMECertificate plato_dns_cert1


Get-ACMECertificate plato_dns_cert1 -ExportKeyPEM           "C:\src\certs\plato_dns_cert1.key.pem"
Get-ACMECertificate plato_dns_cert1 -ExportCertificatePEM   "C:\src\certs\plato_dns_cert1.crt.pem"
Get-ACMECertificate plato_dns_cert1 -ExportIssuerPEM        "C:\src\certs\plato_dns_cert1-issuer.crt.pem"

Add-Content -Value (Get-Content plato_dns_cert1.crt.pem)        -Path haproxy.plato.emptool.com.pem
Add-Content -Value (Get-Content plato_dns_cert1-issuer.crt.pem) -Path haproxy.plato.emptool.com.pem
Add-Content -Value (Get-Content plato_dns_cert1.key.pem)        -Path haproxy.plato.emptool.com.pem