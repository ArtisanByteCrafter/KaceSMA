Function Set-ServiceDeskTicket {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'medium'
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
        $Id,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body
    )
    Begin { }
    Process {
        $Endpoint = "/api/service_desk/tickets/{0}" -f $Id

        If ($PSCmdlet.ShouldProcess($Server, "PUT $Endpoint")) {
            $newApiPUTRequestSplat = @{
                Body     = $Body
                Endpoint = $Endpoint
            }
            $Result = New-ApiPUTRequest @newApiPUTRequestSplat
        }
    }
    End {
        $Result
    }
}