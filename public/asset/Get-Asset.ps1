Function Get-Asset {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(
        [Parameter(Position = 0)]
        [int]
        $AssetID,

        [Parameter()]
        [switch]
        $AsBarcodes,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin {
        $Endpoint = '/api/asset/assets'
        If ($AssetID) {
            $Endpoint = "/api/asset/assets/{0}" -f $AssetID
            If ($AsBarcodes) {
                $Endpoint = "/api/asset/assets/{0}/barcodes" -f $AssetID
            }
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