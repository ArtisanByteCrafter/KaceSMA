Function Get-UserPermissions {
    param(
    [Parameter(Mandatory = $true)]
    [string]
    $Server,

    [Parameter(Mandatory = $true)]
    [string]
    $Org,

    [Parameter(Mandatory = $true)]
    [string]
    $UserID,

    [Parameter(Mandatory = $true)]
    [PSCredential]
    $Credential,

    [Parameter()]
    [string]
    $QueryParameters

    )

    $Endpoint = "/ams/shared/api/accounts/"
    New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -QueryParameters $QueryParameters -Credential $Credential
}