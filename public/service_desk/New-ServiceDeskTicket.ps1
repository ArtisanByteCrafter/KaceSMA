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
                'title'='test-ticket'
                'hu_queue_id= 1
                'submitter' = 1234
                "custom_1" = 'custom field 1 text'
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
        [Parameter(Mandatory = $true)]
        [string]
        $Server,

        [Parameter()]
        [string]
        $Org = 'Default',

        [Parameter(Mandatory = $true)]
        [PSCredential]
        $Credential,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body
    )
    Begin {
        $Endpoint = '/api/service_desk/tickets'
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server,"POST $Endpoint")) {
            New-ApiPOSTRequest -Server $Server -Endpoint $Endpoint -Org $Org -Credential $Credential -Body $Body
        }
    }
    End {}
}