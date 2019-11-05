Function Get-ScriptRunStatus {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(
        [Parameter(Mandatory,Position = 0)]
        [int]
        $RunID
    )
    Begin {
        $Endpoint = "/api/script/runStatus/{0}" -f $RunID

    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            New-ApiGETRequest -Endpoint $Endpoint
        }
    }
    End { }
}