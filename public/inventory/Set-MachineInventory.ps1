Function Set-MachineInventory {
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
        [Alias('MachineId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body
    )
    Begin { }
    Process {
        $Endpoint = "/api/inventory/machines/{0}" -f $Id

        If ($PSCmdlet.ShouldProcess($Server, "PUT $Endpoint")) {
            Write-Warning "This cmdlet invokes a client-side inventory check-in to the appliance."

            $newApiPUTRequestSplat = @{
                Body     = $Body
                Endpoint = $Endpoint
            }
            $Result = New-ApiPUTRequest @newApiPUTRequestSplat
        }
    }
    End {
        $Result
    }
}