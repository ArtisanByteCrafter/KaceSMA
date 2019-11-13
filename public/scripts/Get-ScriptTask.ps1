Function Get-ScriptTask {
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

        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [Alias('OrderId')]
        [int]
        $OrdinalID
    )
    Begin { }
    Process {
        $Endpoint = "/api/script/{0}/tasks" -f $Id

        If ($OrdinalID) {
            $Endpoint = "/api/script/{0}/task/{1}" -f $Id, $OrdinalID
        }

        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            $Result = New-ApiGETRequest -Endpoint $Endpoint
        }
    }
    End {
        $Result
    }
}