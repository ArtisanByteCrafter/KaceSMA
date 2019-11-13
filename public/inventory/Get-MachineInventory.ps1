Function Get-MachineInventory {
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
        [Alias('MachineId')]
        [int]
        $Id,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin { }
    Process {
        $Endpoint = '/api/inventory/machines'
        
        If ($Id) {
            $Endpoint = "/api/inventory/machines/{0}" -f $Id
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
        $Result.Machines
    }
}