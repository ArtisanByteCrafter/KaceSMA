Function Get-ManagedInstallMachineCompatibility {
    <#
    .DESCRIPTION
        Returns managed installs associated with a machine ID.
      
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER MachineID
        The ID of the inventory machine you wish to retrieve the managed installs for.
    
    .PARAMETER QueryParameters
        (Optional) Any additional query parameters to be included. String must begin with a <?> character.

    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        Get-SmaManagedInstallMachineCompatibility -Server https://kace.example.com -Org Default -Credential (Get-Credential) -MachineID 1234

        Retrieves managed install information about an inventory device with ID 1234

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

        [Parameter(Mandatory = $true)]
        [int]
        $MachineID,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin {
        $Endpoint = "/api/managed_install/machines/$MachineID/"
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server,"GET $Endpoint")) {
            New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -QueryParameters $QueryParameters -Credential $Credential
        }
    }
    End {}
}