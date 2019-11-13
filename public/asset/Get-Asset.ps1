Function Get-Asset {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
            )]
        [Alias('AssetId')]
        [int]
        $Id,

        [Parameter()]
        [switch]
        $AsBarcodes,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin { }
    Process {
        $Endpoint = '/api/asset/assets'
        If ($Id) {
            $Endpoint = "/api/asset/assets/{0}" -f $Id
            If ($AsBarcodes) {
                $Endpoint = "/api/asset/assets/{0}/barcodes" -f $Id
            }
        }

        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            $newApiGETRequestSplat = @{
                QueryParameters = $QueryParameters
                Endpoint        = $Endpoint
            }
            $Result = New-ApiGETRequest @newApiGETRequestSplat
        }
    }
    End {
        $Result.Assets
    }
}