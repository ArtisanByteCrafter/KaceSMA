Function New-AssetBarcode {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(

        [Parameter(
            Mandatory,
            Position = 0,
            ValueFromPipeline
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body
    )
    Begin { }
    Process {
        $Endpoint = '/api/asset/barcodes'

        If ($PSCmdlet.ShouldProcess($Server, "POST $Endpoint")) {
            $newApiPOSTRequestSplat = @{
                Body     = $Body
                Endpoint = $Endpoint
            }
            $Result = New-ApiPOSTRequest @newApiPOSTRequestSplat
        }
    }
    End {
        $Result
    }
}