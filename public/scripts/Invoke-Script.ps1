Function Invoke-Script {
    <#
    .DESCRIPTION
        Runs a specified script agains a list of given machineIDs

    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER ScriptID
        The ID of the script you'd like to execute.

    .PARAMETER TargetMachineIDs
        An array, or comma seperated list of machine IDs to execute the script against.
        Both @(1,2,3,4) and 1,2,3,4 are valid.

    .INPUTS

    .OUTPUTS
        Integer
        
        0=Failure
        non 0 = runNow ID

    .EXAMPLE
        Invoke-SmaScript -Server 'https://kace.example.com' -Credential (Get-Credential) -ScriptID 1234 -TargetMachineIDs 5678,2345,4567

        Runs a script with ID 1234 against machines with IDs 5678,2345,4567

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
        [int]
        $ScriptID,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [array]
        $TargetMachineIDs

    )
    Begin {
        $Endpoint = "/api/script/$ScriptID/actions/run"
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server,"POST $Endpoint")) {
            $Machines = $TargetMachineIDs -join ','
            New-ApiPOSTRequest -Server $Server -Endpoint $Endpoint -Org $Org -Credential $Credential -QueryParameters "?machineIDs=$Machines"
        }
    }
    End {}
}