Function Get-ServiceDeskQueueField {
    <#
    .DESCRIPTION
        Returns a list of all a queue’s fields.

    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER QueueID
        The ID of the queue who's fields you'd like information about.

    .PARAMETER QueryParameters
        (Optional) Any additional query parameters to be included. String must begin with a <?> character.

    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        Get-SmaServiceDeskQueueField  -Server https://kace.example.com -Org Default -Credential (Get-Credential) -QueueID 1234

        Retrieves field information about a queue with ID 1234.

    .NOTES
       
    #>
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
            $Endpoint = "/api/service_desk/queues/{0}/fields" -f $QueueID
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            $newApiGETRequestSplat = @{
                QueryParameters = $QueryParameters
                Endpoint = $Endpoint
            }
            New-ApiGETRequest @newApiGETRequestSplat
        }
    }
    End {}
}