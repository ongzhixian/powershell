################################################################################
# This is a template file that is used by other scripts that need to setup an administrative user account.
# $admin_username   = A string representing username (eg. "Admin")
# $admin_password   = Password for this user account.
# $admin_credential = PSCredential use for setting up the user account

$admin_username   = "xxxxxxx"
$admin_password   = ConvertTo-SecureString "xxxxxxxxxxxxxx" -AsPlainText -Force
$admin_credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $admin_username, $admin_password