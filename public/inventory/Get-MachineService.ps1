Function Get-MachineService {
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
    $ServiceID,

    [Parameter()]
    [string]
    $QueryParameters
    )

    $Endpoint = '/api/inventory/services/'
    If ($ServiceID) {
        $Endpoint = "/api/inventory/services/$ServiceID/"
    }

    New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -QueryParameters $QueryParameters -Credential $Credential
}