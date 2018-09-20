Function New-Script {
    <#
    .DESCRIPTION
        Creates a new script. The -Body payload parameters determine what type of script is created.
        Types of script include online/offline kscript and online/offline shell script.

    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER Body
        A hashtable-formatted payload with parameters for the new script.

    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
    $scriptparams = @{
        'name' = 'xMy New Script'
        'description' = 'This script is amazing.'
        'enabled' = $False
        'status' = 'Draft'
        'notes'='These are the notes'
        'scheduleType'='online-kscript'
        'alertEnabled' = $False
    }
        New-SmaScript -Server https://kace.example.com -Org Default -Credential (Get-Credential) -ScriptID 1234 -Body $scriptparams

        Creates a new  script ID 1234, gives it 2 attempts with a break on failure. On remediation failure, it logs a status message.

    .NOTES
       
    #>
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'medium'
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
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body

    )
    Begin {
        $Endpoint = "/api/script" # Not Working yet, so not exposed
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server,"POST $Endpoint")) {
            New-ApiPOSTRequest -Server $Server -Endpoint $Endpoint -Org $Org -Credential $Credential -Body $Body
        }
    }
    End {}
}