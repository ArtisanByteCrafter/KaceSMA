Function Get-ScriptRunStatus {
    <#
    .DESCRIPTION
        Returns information about the status of a running script using the runID. Equivalent to the 'Run Now Status' in the SMA admin page.
      
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER RunID
        The ID of the job who's run status you want to return.

    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        Get-SmaScriptRunStatus -Server https://kace.example.com -Org Default -Credential (Get-Credential) -RunID 1234

        Retrieves the runStatus of job with ID 1234.

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
        $RunID
    )
    Begin {
        $Endpoint = "/api/script/runStatus/$RunID"

    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server,"GET $Endpoint")) {
            New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -Credential $Credential
        }
    }
    End {}
}