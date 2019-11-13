Function Invoke-Script {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'medium'
    )]
    param(
        [Parameter(
            Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [Alias('ScriptId')]
        [int]
        $Id,

        [Parameter(
            Mandatory,
            Position = 1
        )]
        [ValidateNotNullOrEmpty()]
        [array]
        $TargetMachineID

    )
    Begin { }
    Process {
        $Endpoint = "/api/script/{0}/actions/run" -f $Id
        $Machines = $TargetMachineID -join ','

        If ($PSCmdlet.ShouldProcess($Server, "POST $Endpoint")) {
            
            $newApiPOSTRequestSplat = @{
                QueryParameters = "?machineIDs={0}" -f $Machines
                Endpoint        = $Endpoint
            }
            $Result = New-ApiPOSTRequest @newApiPOSTRequestSplat
        }
    }
    End {
        [PSCustomObject]@{
            RunId = $Result
        }
    }
}