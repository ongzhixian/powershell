param (
    [string]$out_folder=$null
    )
    
########################################
# Parameter checking
######################################## 

if (!$out_folder) {
    Write-Host "Parameter out_folder is not defined."
    return
}

########################################
# Display operating parameters
######################################## 

Write-Host "Operating parameters are:"
Write-Host "`$out_folder    [$out_folder]"

########################################
# Constants
######################################## 

Set-Variable dev_conn_str -option Constant -value "Data Source=192.168.8.89; Initial Catalog=AlgoEnvironment;User Id=sa;Password=qu4dr4n8Singapore; MultipleActiveResultSets=True"
Set-Variable prd_conn_str -option Constant -value "Data Source=10.50.20.108;Initial Catalog=AlgoEnvironment;User ID=sa;Password=br@hm@nSingapore; MultipleActiveResultSets=True"

########################################
# Functions
######################################## 
$conn_str = $prd_conn_str


# $out_path = Join-Path $out_folder $account
# if ($(Test-Path $out_path) -eq $false) {
#     New-Item $out_path -ItemType Directory
# }


# Get the account ID
$conn_str
[System.Data.SqlClient.SqlConnection] $connection = New-Object System.Data.SqlClient.SqlConnection($conn_str)
[System.Data.SqlClient.SqlCommand] $cmd = $connection.CreateCommand()
$cmd.Parameters.Clear()
#$cmd.CommandText = "SELECT SecurityId, QuantityBought, QuantitySold, QuantityBought - QuantitySold AS 'QuantityDiff', Provider, Exchange FROM Position WHERE [AccountCode] = @accountCode AND [Provider] IN (17, 21, 22) AND StrategyName = 'Trader Config' AND Exchange = 20"
$cmd.CommandText = @"
SELECT	p.SecurityId, p.QuantityBought - p.QuantitySold AS 'QuantityDiff', p.[Provider],  p.[AccountCode]
FROM	Position p
INNER JOIN Instrument i
		ON p.SecurityId = i.SecurityID
		AND i.MaturityDate > GETDATE()
WHERE	(p.[AccountCode] = 'robasxms')
		AND p.[Provider] IN (13) 
		AND p.StrategyName = 'Trader Config' 
		AND p.Exchange = 16 
ORDER BY p.SecurityId, p.Exchange, p.[Provider], p.[AccountCode]
"@

#$null = $cmd.Parameters.AddWithValue("@accountCode", $account)
[System.Data.SqlClient.SqlDataAdapter] $da = New-Object System.Data.SqlClient.SqlDataAdapter($cmd)
[System.Data.DataSet] $ds = New-Object System.Data.DataSet("positions")

$filename =  $(Get-Date).ToString("yyyyMMdd-HHmmss") + ".csv"
$out_filepath = Join-Path $out_folder $filename

try {
    $null = $da.Fill($ds)
    $ds.Tables[0] | Export-Csv -Path $out_filepath -NoTypeInformation
    Write-Host "File saved to $out_filepath"
}
catch {
    Write-Host "Exception $_"
}
