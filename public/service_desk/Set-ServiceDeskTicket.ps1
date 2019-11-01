Function Set-ServiceDeskTicket {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'medium'
    )]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]
        $TicketID,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body
    )
    Begin {
        $Endpoint = "/api/service_desk/tickets/{0}" -f $TicketID
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "PUT $Endpoint")) {
            $newApiPUTRequestSplat = @{
                Body     = $Body
                Endpoint = $Endpoint
            }
            New-ApiPUTRequest @newApiPUTRequestSplat
        }
    }
    End { }
}