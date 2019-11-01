Function Set-MachineInventory {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'medium'
    )]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]
        $MachineID,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body
    )
    Begin {
        $Endpoint = "/api/inventory/machines/{0}" -f $MachineID
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "PUT $Endpoint")) {
            Write-Warning "This cmdlet invokes a client-side inventory check.
            See: https://github.com/ArtisanByteCrafter/KaceSMA/wiki/FAQ#q-set-smamachineinventory-triggers-a-client-side-inventory"

            $newApiPUTRequestSplat = @{
                Body     = $Body
                Endpoint = $Endpoint
            }
            New-ApiPUTRequest @newApiPUTRequestSplat
        }
    }
    End { }
}