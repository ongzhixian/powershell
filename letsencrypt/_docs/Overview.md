wordpress.plato.emptool.com
plato.emptool.com
brahman-devops.plato.emptool.com
plato-dev-bot.plato.emptool.com
plato-trading-bot.plato.emptool.com

```
Install-Module -Name ACMESharp -AllowClobber
Import-Module ACMESharp
Initialize-ACMEVault
New-ACMERegistration -Contacts mailto:zhixian@hotmail.com -AcceptTos

...

New-ACMEIdentifier -Dns plato.emptool.com -Alias plato_dns

```

New-ACMEIdentifier -Dns plato.emptool.com 					-Alias plato_dns
New-ACMEIdentifier -Dns brahman-devops.plato.emptool.com 	-Alias brahman-devops.plato
New-ACMEIdentifier -Dns plato-dev-bot.plato.emptool.com 	-Alias plato-dev-bot.plato
New-ACMEIdentifier -Dns plato-trading-bot.plato.emptool.com -Alias plato-trading-bot.plato
New-ACMEIdentifier -Dns wordpress.plato.emptool.com 		-Alias wordpress.plato


== Manual Challenge Handler - HTTP ==
  * Handle Time:      [4/14/2019 11:14:40 AM]
  * Challenge Token:  [TIE_-M0vlshYaR-SjTKqV2Xwbe4K9W_eLQrFS2kHTCI]

To complete this Challenge please create a new file
under the server that is responding to the hostname
and path given with the following characteristics:
  * HTTP URL:     [http://plato.emptool.com/.well-known/acme-challenge/TIE_-M0vlshYaR-SjTKqV2Xwbe4K9W_eLQrFS2kHTCI]
  * File Path:    [.well-known/acme-challenge/TIE_-M0vlshYaR-SjTKqV2Xwbe4K9W_eLQrFS2kHTCI]
  * File Content: [TIE_-M0vlshYaR-SjTKqV2Xwbe4K9W_eLQrFS2kHTCI.sJaBIM5fNEDMCrairw1N-D-YSngX7m_X1INS4WhHP-k]
  * MIME Type:    [text/plain]
------------------------------------