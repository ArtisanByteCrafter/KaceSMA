Function Get-Script {
    <#
    .DESCRIPTION
        Returns information about a specific script.
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER ScriptID
        (Optional) If used, this is the ID of the script you'd like information about. If not provided, all scripts are returned

    .PARAMETER QueryParameters
        (Optional) Any additional query parameters to be included. String must begin with a <?> character.

    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
         Get-SmaScript -Server https://kace.example.com -Org Default -Credential (Get-Credential)

         Retrieves information about all scripts in the org.
         
    .EXAMPLE
        Get-SmaScript -Server https://kace.example.com -Org Default -Credential (Get-Credential) -ScriptID 1234

        Retrieves information about a script with ID 1234.

    .NOTES
       
    #>
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(
        [Parameter()]
        [int]
        $ScriptID,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin {
        $Endpoint = "/api/scripts"
        If ($ScriptID) {
            $Endpoint = "/api/script/{0}" -f $ScriptID
        }
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            $newApiGETRequestSplat = @{
                QueryParameters = $QueryParameters
                Endpoint        = $Endpoint
            }
            New-ApiGETRequest @newApiGETRequestSplat
        }
    }
    End { }
}