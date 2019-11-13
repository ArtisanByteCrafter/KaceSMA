Function Set-AssetAsArchived {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(

        [Parameter(
            Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [Alias('AssetId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body
    )
    Begin { }
    Process {
        $Endpoint = "/api/asset/assets/{0}/archive" -f $Id

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