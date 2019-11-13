Function Get-ScriptDependency {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
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

        [Parameter()]
        [string]
        $DependencyName
    )
    Begin { }
    Process {
        $Endpoint = "/api/script/{0}/dependencies" -f $Id
        
        If ($DependencyName) {
            $Endpoint = "/api/script/{0}/dependency/{1}" -f $Id, $DependencyName
        }

        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            New-ApiGETRequest -Endpoint $Endpoint
        }
    }
    End { }
}