Function Get-ServiceDeskQueue {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(
        [Parameter()]
        [int]
        $QueueID,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin {
        $Endpoint = "/api/service_desk/queues"
        If ($QueueID) {
            $Endpoint = "/api/service_desk/queues/{0}" -f $QueueID
        }
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            $newApiGETRequestSplat = @{
                QueryParameters = $QueryParameters
                Endpoint        = $Endpoint
            }
            New-ApiGETRequest @newApiGETRequestSplat
        }
    }
    End { }
}