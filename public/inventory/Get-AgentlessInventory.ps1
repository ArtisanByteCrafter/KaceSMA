Function Get-AgentlessInventory {
    <#
    .DESCRIPTION
        Returns information about the SMA agentless inventory, or a specific node.
      
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER NodesID
        (Optional) Use if you want to return a specific agentless node from the SMA.

    .PARAMETER QueryParameters
        (Optional) Any additional query parameters to be included. String must begin with a <?> character.

    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        Get-SmaAgentlessInventory -Server https://kace.example.com -Org Default -Credential (Get-Credential)

        Retrieves information about all agentless inventory nodes
        
    .EXAMPLE
        Get-SmaAgentlessInventory -Server https://kace.example.com -Org Default -Credential (Get-Credential) -NodeID 1234

        Retrieves node information about an agentless node with with ID 1234.

    .NOTES
       
    #>
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(
        
        [Parameter()]
        [int]
        $NodesID,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin {
        $Endpoint = '/api/inventory/nodes'

        If ($NodesID) {
            $Endpoint = "/api/inventory/nodes/{0}" -f $NodesID
        }
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server,"GET $Endpoint")) {
            $newApiGETRequestSplat = @{
                QueryParameters = $QueryParameters
                Endpoint = $Endpoint
            }
            New-ApiGETRequest @newApiGETRequestSplat
        }
    }
}