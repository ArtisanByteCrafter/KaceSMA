Function Get-OperatingSystemInventory {
    <#
    .DESCRIPTION
        Returns information about operating systems for SMA inventory devices, or for  specific inventory device.
      
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER MAchineID
        (Optional) Use if you want to return the operating system information about a specific inventory device.

    .PARAMETER QueryParameters
        (Optional) Any additional query parameters to be included. String must begin with a <?> character.

    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        Get-SmaOperatingSystemInventory -Server https://kace.example.com -Org Default -Credential (Get-Credential)

        Retrieves information about all inventory devices' operating systems.
        
    .EXAMPLE
        Get-SmaOperatingSystemInventory -Server https://kace.example.com -Org Default -Credential (Get-Credential) -MachineID 1234

        Retrieves operating system information for an inventory device with ID 1234.

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
        $Endpoint = '/api/inventory/operating_systems/'
        If ($MachineID) {
            $Endpoint = "/api/inventory/operating_systems/$MachineID/"
        }
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server)) {
            New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -QueryParameters $QueryParameters -Credential $Credential
        }
    }
    End {}
}