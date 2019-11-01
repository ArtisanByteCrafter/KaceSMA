Function Get-ScriptTask {
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