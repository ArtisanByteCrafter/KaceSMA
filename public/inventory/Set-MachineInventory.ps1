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
        [Parameter(Mandatory = $true,Position=0)]
        [string]
        $MachineID,

        [Parameter(Mandatory = $true)]
        [string]
        $Server,

        [Parameter()]
        [string]
        $Org = 'Default',

        [Parameter(Mandatory = $true)]
        [PSCredential]
        $Credential,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body
    )
    Begin {
        $Endpoint = "/api/inventory/machines/$MachineID"
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server,"PUT $Endpoint")) {
            Write-Warning "This cmdlet invokes a client-side inventory check.
        Additional info: https://github.com/ArtisanByteCrafter/KaceSMA/wiki/FAQ#q-set-smamachineinventory-triggers-a-client-side-inventory"

            New-ApiPUTRequest -Server $Server -Endpoint $Endpoint -Org $Org -Credential $Credential -Body $Body
        }
    }
    End {}
}