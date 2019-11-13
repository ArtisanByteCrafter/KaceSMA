Function Get-ScriptRunStatus {
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
        [Alias('RunId')]
        [int]
        $Id
    )
    Begin { }
    Process {
        $Endpoint = "/api/script/runStatus/{0}" -f $Id

        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            $Result = New-ApiGETRequest -Endpoint $Endpoint
        }
    }
    End {
        $Result
    }
}