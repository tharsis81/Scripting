
$resourceGroups = (get-azresourcegroup)

$resourcesId = foreach ($resourceGroup in $resourceGroups)
{
    $resourceGroupName = $resourceGroup.ResourceGroupName
    get-azresource -resourcegroupname $resourceGroupName | Where-Object -FilterScript {
        $_.ResourceType -NE 'Microsoft.Network/virtualNetworks' `
        -AND $_.ResourceType -NE 'Microsoft.Network/privateEndpoints' `
        -AND $_.ResourceType -NE 'Microsoft.Network/privateDnsZones/virtualNetworkLinks' `
        -AND $_.ResourceType -NE 'Microsoft.Network/privateDnsZones' `
        -AND $_.ResourceType -NE 'Microsoft.Network/networkSecurityGroups' `
        -AND $_.ResourceType -NE 'Microsoft.Sql/servers/databases' `
        -AND $_.ResourceType -NE 'Microsoft.Resources/deploymentScripts' `
        -AND $_.ResourceType -NE 'Microsoft.ManagedIdentity/userAssignedIdentities' `
        -AND $_.ResourceType -NE 'Microsoft.Network/networkWatchers' `
        -AND $_.ResourceType -NE 'Microsoft.Network/networkIntentPolicies' `
        -AND $_.ResourceType -NE 'Microsoft.Network/networkInterfaces' `
        -AND $_.ResourceType -NE 'Microsoft.Databricks/workspaces' `
        -AND $_.ResourceType -NE 'Microsoft.Synapse/workspaces/bigDataPools' `
        -AND $_.ResourceType -NE 'Microsoft.Synapse/workspaces/sqlPools' `
        -AND $_.ResourceType -NE 'Microsoft.Web/serverFarms'
    }
}

foreach ($resourceId in $resourcesId) {
    if ($resourceId) {
        $resourcePendingConnection = Get-AzPrivateEndpointConnection -PrivatelinkResourceId $resourceId.ResourceId | Where-Object -FilterScript {$_.PrivateLinkServiceConnectionState.Status -EQ 'Pending'}
        if ($resourcePendingConnection) {
            foreach ($connection in $resourcePendingConnection)
            {
                Approve-AzPrivateEndpointConnection -ResourceId $connection.Id
            }
        }
        else
        {
            Write-Output 'No pending connections for Resource: ' $resourceId.Name
        }
    }
    else
    {
        Write-Output 'No resource found with name: ' $resourceId.Name
    }
}
    
