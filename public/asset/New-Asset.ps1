Function New-Asset {
    <#
    .DESCRIPTION
        Creates a new SMA asset.
      
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)


    .PARAMETER Body
        A hashtable-formatted payload containing the asset information. See example.
    
    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        $NewAgentAsset = @{
            'Assets' =@(
                @{
                'name'='x2test'
                "asset_type_id" = 5
                'location_id' = 7080
                'asset_type_name' = "Computer with Dell Agent"
                }
            )
        }

        New-SmaAsset -Server https://kace.example.com -Org Default -Credential (Get-Credential) -Body $NewAgentAsset

        Creates a new SMA asset or type 'Computer with Dell Agent'.

    .NOTES
       
    #>
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(

        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body
    )
    Begin {
        $Endpoint = '/api/asset/assets'
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