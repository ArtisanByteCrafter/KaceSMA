Function Get-ScriptDependency {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(
        [Parameter(Mandatory)]
        [int]
        $ScriptID,

        [Parameter()]
        [string]
        $DependencyName
    )
    Begin {
        $Endpoint = "/api/script/{0}/dependencies" -f $ScriptID
        If ($DependencyName) {
            $Endpoint = "/api/script/{0}/dependency/{1}" -f $ScriptID, $DependencyName
        }

    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            New-ApiGETRequest -Endpoint $Endpoint
        }
    }
    End { }
}