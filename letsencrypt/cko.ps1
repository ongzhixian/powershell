<#
.SYNOPSIS

Checks for connections on port 3389 and sends a Telegram message.

.DESCRIPTION

Checks for connections on port 3389 and sends a Telegram message.

.EXAMPLE

To run the script, just execute:

checkpoint-rdp

.NOTES

Currently the token and chat_id are hardcoded.

The token "416208415:AAEfO6AoW5yXqLZzQHZabuV1ZFFYnLo0g8E" refers to a Telegram chat bot, brahman-devops.
The chat_id "53274105"          refers to Zhixian's Telegram account.
The chat_id "-1001114131130"    refers to Brahman-Devops channel.

To run this script discreetly (say using Task Scheduler), you might want to have the following parameters:

-nologo -noninteractive -WindowStyle Hidden -command "& 'C:\Windows\System32\WindowsPowerShell\v1.0\Examples\checkpoint-rdp.ps1'"

If the script is not running, you can run it as such to see it works:

powershell -command "& 'C:\Windows\System32\WindowsPowerShell\v1.0\Examples\checkpoint-rdp.ps1'"

#>

param(
    [int]$step=1,
    [string]$dns=$null
)

################################################################################
# Import(s)
################################################################################

Import-Module ACMESharp

################################################################################
# Function(s)
################################################################################

function Display-Challenge($dns_alias) {
    $http_challenge = (Get-ACMEIdentifier plato_dns).Challenges | Where-Object {$_.Type -eq "http-01"}
    $msg_lines = $http_challenge.HandlerHandleMessage.split("`n")

    # Parse for HTTP URL
    #   * HTTP URL:     [http://plato.emptool.com/.well-known/acme-challenge/TIE_-M0vlshYaR-SjTKqV2Xwbe4K9W_eLQrFS2kHTCI]
    $regex_match = $msg_lines | Select-String "\* HTTP URL:\s+\[(.+)\]"
    $http_url = $regex_match.Matches.Groups[1].Value
    $filename = Split-Path $http_url -leaf

    # Parse for File Content
    #   * File Content: [TIE_-M0vlshYaR-SjTKqV2Xwbe4K9W_eLQrFS2kHTCI.sJaBIM5fNEDMCrairw1N-D-YSngX7m_X1INS4WhHP-k]
    $regex_match = $msg_lines | Select-String "\* File Content:\s+\[(.+)\]"
    $file_content = $regex_match.Matches.Groups[1].Value

    Write-Host "Challenge details for HTTP-01"
    Write-Host "HTTP URL:       [$http_url]"
    Write-Host "Filename:       [$filename]"
    Write-Host "File Content:   [$file_content]"
}

function Test-AliasExist($dns_alias) {
    # function to check if alias exists 
    $acme_id = Get-ACMEIdentifier | Where-Object {$_.Alias -eq $dns_alias}
    return -not ($acme_id -eq $null)
}

################################################################################
# Main script
################################################################################

if ($dns.length -le 0) {
    Write-Host "Parameter [dns] was not specified.`nTerminating script.`n"
    exit
}

Write-Host "Checking if [$dns] is defined."
$acme_id_exists = Test-AliasExist $dns
Write-Host "[$dns] is defined? $acme_id_exists"

if ($acme_id_exists -eq $false) {
    Write-Host "Please re-run reinit.ps1 before running this script again."
    exit
}


if ($step -eq 0) {
    Complete-ACMEChallenge $dns -ChallengeType http-01 -Handler manual
    
    
    $b = (Update-ACMEIdentifier plato_dns -ChallengeType http-01).Challenges | Where-Object {$_.Type -eq "http-01"}
    $b
    Write-Host "Status: [$($b.status)]"
    exit
}

if ($step -eq 1) {
    Display-Challenge
    exit
}

if ($step -eq 2) {
    Write-Host "TODO: Complete challenge"
    Submit-ACMEChallenge $dns -ChallengeType http-01

    $b = (Update-ACMEIdentifier plato_dns -ChallengeType http-01).Challenges | Where-Object {$_.Type -eq "http-01"}

    $date_str = (Get-Date).ToString("yyyyMMdd")
    $cert_alias = "$($dns)_cert_$($date_str)"
    Write-Host $cert_alias
    New-ACMECertificate $dns -Generate -Alias $cert_alias
    Submit-ACMECertificate $cert_alias
    Update-ACMECertificate $cert_alias
    
}
