Function Get-ManagedInstall {
    <#
    .DESCRIPTION
        Returns information about SMA managed installs.
      
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER ManagedInstallID
        (Optional) Use if you want to return the information about a specific managed install.

    .PARAMETER ListCompatibleMachines
        (Optional) Use with -ManagedInstallID if you want to return all machines compatible with a specific managed install.

    .PARAMETER QueryParameters
        (Optional) Any additional query parameters to be included. String must begin with a <?> character.

    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        Get-SmaManagedInstall -Server https://kace.example.com -Org Default -Credential (Get-Credential)

        Retrieves information about all managed installs.
        
    .EXAMPLE
        Get-SmaManagedInstall -Server https://kace.example.com -Org Default -Credential (Get-Credential) -ManagedInstallID 1234

        Retrieves information for a managed install with ID 1234.

    .EXAMPLE
        Get-SmaManagedInstall -Server https://kace.example.com -Org Default -Credential (Get-Credential) -ManagedInstallID 1234 -ListCompatibleMachines

        Retrieves machines compatible with -managedinstallID 1234

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
        [int]
        $ManagedInstallID,

        [Parameter()]
        [switch]
        $ListCompatibleMachines,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin {
        $Endpoint = '/api/managed_install/managed_installs'
        If ($ManagedInstallID) {
            $Endpoint = "/api/managed_install/managed_installs/$ManagedInstallID"
            If ($ListCompatibleMachines) {
                $Endpoint = "/api/managed_install/managed_installs/$ManagedInstallID/compatible_machines"
            }
        }
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server,"GET $Endpoint")) {
            New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -QueryParameters $QueryParameters -Credential $Credential
        }
    }
    End {}
}