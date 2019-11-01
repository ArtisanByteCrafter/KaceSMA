Function Remove-ServiceDeskTicket {
    <#
    .DESCRIPTION
        Deletes a service desk ticket.
      
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER TicketID
        The ID of the ticket you want to update


    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE


        Remove-SmaServiceDeskTicket -Server https://kace.example.com -Org Default -Credential (Get-Credential) -TicketID 1234 

        Deletes a ticket with ID 1234        

    .NOTES
       
    #>
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