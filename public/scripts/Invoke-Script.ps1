Function Invoke-Script {
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
        [array]
        $TargetMachineID

    )
    Begin {
        $Endpoint = "/api/script/{0}/actions/run" -f $ScriptID
        $Machines = $TargetMachineID -join ','
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "POST $Endpoint")) {
            
            $newApiPOSTRequestSplat = @{
                QueryParameters = "?machineIDs=$Machines"
                Endpoint        = $Endpoint
            }
            New-ApiPOSTRequest @newApiPOSTRequestSplat
        }
    }
    End { }
}