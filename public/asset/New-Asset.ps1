Function New-Asset {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body
    )
    Begin {
        $Endpoint = '/api/asset/assets'
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "POST $Endpoint")) {
            $newApiPOSTRequestSplat = @{
                Body     = $Body
                Endpoint = $Endpoint
            }
            New-ApiPOSTRequest @newApiPOSTRequestSplat
        }
    }
    End { }
}