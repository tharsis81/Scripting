<#
spodnja koda prebere AD grupe in jih zapiše v SQL tabelo
#>

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
$WebAppURL = "http://iisaportal2019test"

#Invoke-sqlcmd connection string parameters
$params = @{'server'='dw_sql_test';'database'='dw_source'}

#function to manipulate the data
function writeDiskInfo
{
param ($displayName)

#data preparation for loading data into sql table
$insertResults = @"
insert into dw_source.dbo.ad_iisaADGroup (iisaADGroup) values ('$displayName')
"@

#call the invoke-sqlcmdlet to execute the query
Invoke-Sqlcmd @params -query $insertResults
}

#dobimo vse AD grupe
$ADGroups = Get-SPUser -Web $WebAppURL -Limit ALL | Where {$_.IsDomainGroup -and $_.displayName -ne "Everyone" -and $_.displayName -like "a-tvp\*"}
new-object psobject -property @{displayName = $ADGroups.displayName}

#loop
forEach ($group in $adgroups)
{
writeDiskInfo $group.displayName
}

#query
Invoke-Sqlcmd @params -Query "SELECT  * FROM dw_source.dbo.ad_iisaADGroup" | format-table -AutoSize

