Function Set-AssetAsArchived {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(

        [Parameter(Mandatory)]
        [int]
        $AssetID,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body
    )
    Begin {
        $Endpoint = "/api/asset/assets/{0}/archive" -f $AssetID
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