Function Get-AgentlessInventory {
    param(
    [Parameter(Mandatory = $true)]
    [string]
    $Server,

    [Parameter(Mandatory = $true)]
    [string]
    $Org,

    [Parameter(Mandatory = $true)]
    [PSCredential]
    $Credential,

    [Parameter()]
    [string]
    $NodesID,

    [Parameter()]
    [string]
    $QueryParameters
    )

    $Endpoint = '/api/inventory/nodes/'

    If ($NodesID) {
        $Endpoint = "/api/inventory/nodes/$NodesID/"
    }

    New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -QueryParameters $QueryParameters -Credential $Credential
}