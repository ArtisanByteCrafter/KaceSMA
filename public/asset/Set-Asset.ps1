Function Set-Asset {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'medium'
    )]
    param(

        [Parameter(Mandatory,Position = 0)]
        [int]
        $AssetID,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body
    )
    Begin {
        $Endpoint = "/api/asset/assets/{0}" -f $AssetID
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "PUT $Endpoint")) {

            $InvokeParams = @{             
                Endpoint   = $Endpoint
                Body       = $Body
            }
            New-ApiPUTRequest @InvokeParams
        }
    }
    End { }
}