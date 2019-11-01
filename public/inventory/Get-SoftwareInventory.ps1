Function Get-SoftwareInventory {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(
        [Parameter()]
        [string]
        $SoftwareID,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )

    Begin {
        $Endpoint = '/api/inventory/softwares'
        If ($SoftwareID) {
            $Endpoint = "/api/inventory/softwares/{0}" -f $SoftwareID
        }
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            $newApiGETRequestSplat = @{
                QueryParameters = $QueryParameters
                Endpoint        = $Endpoint
            }
            New-ApiGETRequest @newApiGETRequestSplat
        }
    }
    End { }
}