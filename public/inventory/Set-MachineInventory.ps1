Function Set-MachineInventory {
    <#
    .DESCRIPTION
        Updates the inventory information for a device.
      
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER MachineID
        The machine whose information you want to update.

    .PARAMETER Body
        The payload of the update, in hashtable format.

    .INPUTS

    .OUTPUTS
        PSCustomObject

    .NOTES
       
    #>
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