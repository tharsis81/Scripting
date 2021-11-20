<#
code that must be run before using Postman for testing API

https://sharepoint.stackexchange.com/questions/284402/sharepoint-online-authorization-issue-token-type-is-not-allowed

#>

Install-Module -Name Microsoft.Online.SharePoint.PowerShell
$adminUPN="anzepirc@testdoo570.onmicrosoft.com"
$orgName="Testdoo570"
$userCredential = Get-Credential -UserName $adminUPN -Message "Type the password."
Connect-SPOService -Url https://$orgName-admin.sharepoint.com -Credential $userCredential
set-spotenant -DisableCustomAppAuthentication $false 
