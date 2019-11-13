Function Get-AgentlessInventory {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(
        
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [Alias('NodesId')]
        [int]
        $Id,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin { }
    Process {
        $Endpoint = '/api/inventory/nodes'

        If ($ID) {
            $Endpoint = "/api/inventory/nodes/{0}" -f $ID
        }

        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            $newApiGETRequestSplat = @{
                QueryParameters = $QueryParameters
                Endpoint        = $Endpoint
            }
            $Result = New-ApiGETRequest @newApiGETRequestSplat
        }
    }
    End {
        $Result.Nodes
    }
}