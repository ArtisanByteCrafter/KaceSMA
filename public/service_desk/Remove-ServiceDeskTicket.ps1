Function Remove-ServiceDeskTicket {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'high'
    )]
    param(
        [Parameter(
            Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [Alias('TicketId')]
        [int]
        $Id

    )
    Begin { }
    Process {
        $Endpoint = "/api/service_desk/tickets/{0}" -f $Id

        If ($PSCmdlet.ShouldProcess($Server, "DELETE $Endpoint")) {
            $Result = New-ApiDELETERequest -Endpoint $Endpoint
        }
    }
    End {
        $Result
    }
}