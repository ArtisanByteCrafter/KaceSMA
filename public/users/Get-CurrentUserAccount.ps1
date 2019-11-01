Function Get-CurrentUserAccount {
    <#
    .DESCRIPTION
        Returns information about the current SMA user account being used to perform the api query.

    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .INPUTS

    .OUTPUTS
        PSCustomObject
    
    .EXAMPLE
        Get-SmaCurrentUserAccount -Server https://kace.example.com -Org Default -Credential (Get-Credential)
        
        Retrieves information about the current API user performing the query.

    .NOTES
       
    #>
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(

    )
    Begin {
        $Endpoint = "/api/users/me"
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            New-ApiGETRequest -Endpoint $Endpoint
        }
    }
    End { }
}