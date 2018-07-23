Function Get-MachineProcess {
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
    $ProcessID,

    [Parameter()]
    [string]
    $QueryParameters
    )

    $Endpoint = '/api/inventory/processes/'
    If ($ProcessID) {
        $Endpoint = "/api/inventory/processes/$ProcessID/"
    }

    New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -QueryParameters $QueryParameters -Credential $Credential
}