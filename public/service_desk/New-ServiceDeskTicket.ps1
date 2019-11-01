Function New-ServiceDeskTicket {
    <#
    .DESCRIPTION
        Creates a new SMA service desk ticket.
      
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)


    .PARAMETER Body
        A hashtable-formatted payload containing the ticket information. See example.
    
    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        $NewTicket = @{
            'Tickets' =@(
                @{
                'title' = 'test-ticket'
                'hd_queue_id' = 7
                'submitter' = 14038
                'category' = 579
                "custom_1"    = 'my custom'
                }
            )
        }

        New-SmaTicket -Server https://kace.example.com -Org Default -Credential (Get-Credential) -Body $NewTicket

        Creates a new SMA ticket for a user with ID of 1234

    .NOTES
       
    #>
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body
    )
    Begin {
        $Endpoint = '/api/service_desk/tickets'
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "POST $Endpoint")) {
            $newApiPOSTRequestSplat = @{
                Body     = $Body
                Endpoint = $Endpoint
            }
            New-ApiPOSTRequest @newApiPOSTRequestSplat
        }
    }
    End { }
}