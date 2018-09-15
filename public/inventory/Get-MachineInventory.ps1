Function Get-MachineInventory {
    <#
    .DESCRIPTION
        Returns information about the SMA inventory, or a specific device.
      
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER MachineID
        (Optional) Use if you want to return a specific  machine from the SMA.

    .PARAMETER QueryParameters
        (Optional) Any additional query parameters to be included. String must begin with a <?> character.

    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        Get-SmaMachineInventory -Server https://kace.example.com -Org Default -Credential (Get-Credential)

        Retrieves machine information about all inventory devices
        
    .EXAMPLE
        Get-SmaMachineInventory -Server https://kace.example.com -Org Default -Credential (Get-Credential) -MachineID 1234

        Retrieves machine information about an inventory device with ID 1234.

    .NOTES
       
    #>
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(
        [Parameter(Mandatory = $true)]
        [string]
        $Server,

        [Parameter()]
        [string]
        $Org = 'Default',

        [Parameter(Mandatory = $true)]
        [PSCredential]
        $Credential,

        [Parameter()]
        [string]
        $MachineID,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin {
        $Endpoint = '/api/inventory/machines/'
        If ($MachineID) {
            $Endpoint = "/api/inventory/machines/$MachineID/"
        }
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server)) {
            New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -QueryParameters $QueryParameters -Credential $Credential
        }
    }
    End {}
}