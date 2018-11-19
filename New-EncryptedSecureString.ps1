# New-EncryptedSecureString
########################################
# Overview
########################################

Write-Host "This script is used to generate .secure files."
Write-Host "These are files that will hold the encrypted version of your secure string."

########################################
# Main script
########################################

# Prompt user for input (content); This will be stored as a secure-string.
$secureString = Read-Host -Prompt "Enter the content of your secure string" -AsSecureString
# Encrypt the secure-string
$encryptedSecureString = ConvertFrom-SecureString -SecureString $secureString

# Prompt user for the filename to save the resulting encrypted secure string.
$filename = Read-Host -Prompt "Enter the filename to save the encrypted secure string (omitting the extension .secure)"
$encryptedSecureString > "$filename.secure"
Write-Host "$filename.secure saved."