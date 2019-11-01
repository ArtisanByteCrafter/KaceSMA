Function New-ScriptTask {
    <#
    .DESCRIPTION
        Creates a new script task for a given script ID. Works with online and offline kscripts.

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

    .PARAMETER Body
        A hashtable-formatted payload with instructions for the task to create.


    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        $taskparams = @{
            'attempts' = 2
            'onFailure' = 'break'
            'onRemediationFailure' = @(
                @{
                    'id'= 27
                    'params'= [ordered]@{
                        'type'='status'
                        'message'='this is a test message'
                    }
                }
            )
        }
        New-SmaScriptTask -Server https://kace.example.com -Org Default -Credential (Get-Credential) -ScriptID 1234 -Body $taskparams

        Creates a new task for script ID 1234, gives it 2 attempts with a break on failure. On remediation failure, it logs a status message.

    .NOTES
       
    #>
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'medium'
    )]
    param(
        [Parameter(Mandatory)]
        [int]
        $ScriptID,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body

    )
    Begin {
        $Endpoint = "/api/script/{0}/task" -f $ScriptID
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "POST $Endpoint")) {
            $newApiPOSTRequestSplat = @{
                Body     = $Body
                Endpoint = $Endpoint
            }
            New-ApiPOSTRequest  @newApiPOSTRequestSplat
        }
    }
    End { }
}