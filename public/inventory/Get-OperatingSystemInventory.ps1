Function Get-OperatingSystemInventory {
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
    $MachineID,

    [Parameter()]
    [string]
    $QueryParameters
    )

    $Endpoint = '/api/inventory/operating_systems/'
    If ($MachineID) {
        $Endpoint = "/api/inventory/operating_systems/$MachineID/"
    }

    New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -QueryParameters $QueryParameters -Credential $Credential
}