Function Get-SoftwareInventory {
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
        [Alias('SoftwareId')]
        [int]
        $Id,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )

    Begin { }
    Process {
        $Endpoint = '/api/inventory/softwares'
        If ($Id) {
            $Endpoint = "/api/inventory/softwares/{0}" -f $Id
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
        $Result.Software
    }
}