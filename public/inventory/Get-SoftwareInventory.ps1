Function Get-SoftwareInventory {
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
    $SoftwareID,

    [Parameter()]
    [string]
    $QueryParameters
    )

    $Endpoint = '/api/inventory/softwares/'
    If ($SoftwareID) {
        $Endpoint = "/api/inventory/softwares/$SoftwareID/"
    }

    New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -QueryParameters $QueryParameters -Credential $Credential
}