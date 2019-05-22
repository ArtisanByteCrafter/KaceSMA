Function Get-UserPermissions {
    <#
    .DESCRIPTION
        Returns information about an SMA user permissions.
      
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER UserID
        (Optional) Use if you want to return a specific user's permissions from the SMA.
        ID can be found in SMA Admin > Settings > Users, then looking at the ID= in the url.

    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        Get-SmaUserPermissions -Server https://kace.example.com -Org Default -Credential (Get-Credential) -UserID 1234

        Retrieves information about the permissions for a user with ID 1234

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
        [string]
        $UserID,

        [Parameter(Mandatory = $true)]
        [PSCredential]
        $Credential,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters

    )
    Begin {
        $Endpoint = "/api/users/$UserID/permissions"
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -QueryParameters $QueryParameters -Credential $Credential
        }
    }
    End {}
}