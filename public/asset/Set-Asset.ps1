Function Set-Asset {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'medium'
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
        $Endpoint = "/api/asset/assets/{0}" -f $Id

        If ($PSCmdlet.ShouldProcess($Server, "PUT $Endpoint")) {

            $InvokeParams = @{
                Endpoint = $Endpoint
                Body     = $Body
            }
            $Result = New-ApiPUTRequest @InvokeParams
        }
    }
    End {
        $Result
    }
}