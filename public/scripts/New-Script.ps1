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

        Creates a new  script with the given parameters.
        
    .NOTES
       
    #>
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'medium'
    )]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body

    )
    Begin {
        $Endpoint = "/api/script" # Not Working yet, so not exposed
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "POST $Endpoint")) {
            $newApiPOSTRequestSplat = @{
                Body     = $Body
                Endpoint = $Endpoint
            }
            New-ApiPOSTRequest @newApiPOSTRequestSplat
        }
    }
    End { }
}