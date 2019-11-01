Function Remove-ServiceDeskTicket {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'high'
    )]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]
        $TicketID

    )
    Begin {
        $Endpoint = "/api/service_desk/tickets/{0}" -f $TicketID
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "DELETE $Endpoint")) {
            New-ApiDELETERequest -Endpoint $Endpoint
        }
    }
    End { }
}