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
        [int]
        $OrderID
    )
    Begin {
        $Endpoint = "/api/script/$ScriptID/tasks"
        If ($OrderID) {
            $Endpoint = "/api/script/$ScriptID/task/$OrderID"
        }
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server,"GET $Endpoint")) {
            New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -Credential $Credential
        }
    }
    End {}
}