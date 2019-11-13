Function Get-BarcodeAsset {
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
        [Alias('BarcodeId')]
        [int]
        $Id,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin { }
    Process {
        $Endpoint = '/api/asset/barcodes'
        
        If ($Id) {
            $Endpoint = "/api/asset/barcodes/{0}" -f $Id
        }

        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            $newApiGETRequestSplat = @{
                QueryParameters = $QueryParameters
                Endpoint        = $Endpoint
            }
            $Results = New-ApiGETRequest @newApiGETRequestSplat
        }
    }
    End {
        $Results.Barcodes
    }
}