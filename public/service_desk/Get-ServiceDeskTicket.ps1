Function Get-ServiceDeskTicket {
    <#
    .DESCRIPTION
        Returns a list of all tickets. Sub-entities that can be used on shaping and filtering directives include owner,
        submitter, queue, category, priority, status, machine, asset, related_tickets, referring_tickets

    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER QueryParameters
        (Optional) Any additional query parameters to be included. String must begin with a <?> character.

    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        $queryparameters = "?BY_STATE_TICKETS=all_notclosed&QUEUE_ID=0"

        Get-SmaServiceDeskTicket -Server https://kace.example.com -Org Default -Credential (Get-Credential) -QueryParameters $queryparameters

        Retrieves all "not closed" state tickets from all queues (ID=0)

    .EXAMPLE

        $queryparameters = "?shaping= hd_ticket regular,owner limited,submitter limited"

        Get-SmaServiceDeskTicket -Server $server -Credential $credentials -ticketID 1234 -QueryParameters $queryparameters

        Retrieves the standard attributes, plus owner and submitter for ticket ID 1234

    .NOTES

    #>
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(
        [Parameter(Mandatory = $true)]
        [string]
        $Server,

        [Parameter()]
        [string]
        $Org = 'Default',

        [Parameter(Mandatory = $true)]
        [PSCredential]
        $Credential,


        [int]
        $TicketID,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin {
        $Endpoint = "/api/service_desk/tickets/"
        If ($TicketID){
            $Endpoint = "/api/service_desk/tickets/$TicketID"
        }
        
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -QueryParameters $QueryParameters -Credential $Credential
        }
    }
    End {}
}