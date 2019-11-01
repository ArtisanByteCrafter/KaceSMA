Function Get-ScriptTask {
    <#
    .DESCRIPTION
        Returns task information about a specific script.
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER ScriptID
        The ID of the script who's tasks you'd like information about.

    .PARAMETER OrderID
        (Optional) The order (ordinal) ID of a specific task to be returned.
        The first task in a script is ordinal ID 0, and increments from there.
    .PARAMETER QueryParameters
        (Optional) Any additional query parameters to be included. String must begin with a <?> character.

    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        Get-SmaScriptTask -Server https://kace.example.com -Org Default -Credential (Get-Credential) -ScriptID 1234

        Retrieves task information about a script with ID 1234.

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
        [int]
        $OrderID
    )
    Begin {
        $Endpoint = "/api/script/{0}/tasks" -f $ScriptID
        If ($OrderID) {
            $Endpoint = "/api/script/{0}/task/{1}" -f $ScriptID, $OrderID
        }
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            New-ApiGETRequest -Endpoint $Endpoint
        }
    }
    End { }
}