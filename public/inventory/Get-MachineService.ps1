Function Get-MachineService {
    <#
    .DESCRIPTION
        Returns information about the SMA inventory services, or a specific service.
      
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER ServiceID
        (Optional) Use if you want to return a specific service from the SMA.

    .PARAMETER QueryParameters
        (Optional) Any additional query parameters to be included. String must begin with a <?> character.

    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        Get-SmaMachineService -Server https://kace.example.com -Org Default -Credential (Get-Credential)

        Retrieves service information about all inventory devices
        
    .EXAMPLE
        Get-SmaMachineService -Server https://kace.example.com -Org Default -Credential (Get-Credential) -ServiceID 1234

        Retrieves inventory service information about a service with ID 1234.

    .NOTES
       
    #>
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(
        [Parameter()]
        [string]
        $ServiceID,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )

    Begin {
        $Endpoint = '/api/inventory/services'
        If ($ServiceID) {
            $Endpoint = "/api/inventory/services/{0}" -f $ServiceID
        }
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            $newApiGETRequestSplat = @{
                QueryParameters = $QueryParameters
                Endpoint        = $Endpoint
            }
            New-ApiGETRequest @newApiGETRequestSplat
        }
    }
    End { }
}