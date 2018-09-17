Function Get-ScriptDependency {
    <#
    .DESCRIPTION
        Returns information about dependencies for a specific script.
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER ScriptID
        The ID of the script whose dependencies you want to retrieve.
    
    .PARAMETER DependencyName
        (Optional) The ID of the dependency for a specific script you want to retrieve.

    .PARAMETER QueryParameters
        (Optional) Any additional query parameters to be included. String must begin with a <?> character.

    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        Get-SmaScriptDependency -Server https://kace.example.com -Org Default -Credential (Get-Credential) -ScriptID 1234

        Retrieves information about the dependencies for a script with ID 1234.

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
        $ScriptID,

        [Parameter()]
        [string]
        $DependencyName,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin {
        $Endpoint = "/api/script/$ScriptID/dependencies"
        If ($DependencyName) {
            $Endpoint = "/api/script/$ScriptID/dependency/$DependencyName"
        }

    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server,"GET $Endpoint")) {
            New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -QueryParameters $QueryParameters -Credential $Credential
        }
    }
    End {}
}