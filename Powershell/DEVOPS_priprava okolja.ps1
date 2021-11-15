<#
priprava VS Code okolja

Kaj mora biti nameščeno (seveda je tega še več):
-Azure Powershell
-Azure CLI
-Bicep (potrebno namestiti "extension" in WIN installer)
-gitLense

Kaj ne sme biti nameščeno:
-AzureRM (moramo predhodno odstraniti, da lahko namestimo Azure Powershell)
https://practicalpowershell.com/remove-azurerm-and-install-az-module-for-azure-powershell-management/
#>

#uninstall AzureRM
Get-Module -ListAvailable | Where-Object {$_.Name -like 'AzureRM'} | Uninstall-Module -Force

#Nameščanje ostalih modulov (gremo po MS dokumentaciji)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force