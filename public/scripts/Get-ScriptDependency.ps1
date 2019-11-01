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
        (Optional) The ID of the dependency for a specific script you want to retrieve. If omitted, will return all dependencies

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
        [Parameter(Mandatory)]
        [int]
        $ScriptID,

        [Parameter()]
        [string]
        $DependencyName
    )
    Begin {
        $Endpoint = "/api/script/{0}/dependencies" -f $ScriptID
        If ($DependencyName) {
            $Endpoint = "/api/script/{0}/dependency/{1}" -f $ScriptID, $DependencyName
        }

    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            New-ApiGETRequest -Endpoint $Endpoint
        }
    }
    End { }
}