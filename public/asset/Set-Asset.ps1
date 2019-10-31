Function Set-Asset {
    <#
    .DESCRIPTION
        Updates an SMA asset.
      
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
        $SetAssetBody = @{
            'Assets' = @(
                @{
                    'id'          = 1234
                    'field_10000' = 'My String'
                }
            )
        }

        Set-SmaAsset -Server https://kace.example.com -Org Default -Credential (Get-Credential) -Body $SetAssetBody

        Updates the field 'field_10000' with string 'My String' on asset with ID 1234. Get
        asset field identities using Get-SmaAsset on a similar asset if needed.
        
        (Get-SmaAsset -AssetID 1234 -QueryParameters "?shaping=asset all").Assets

    .NOTES
       
    #>
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'medium'
    )]
    param(

        [Parameter(Mandatory)]
        [int]
        $AssetID,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body
    )
    Begin {
        $Endpoint = "/api/asset/assets/{0}" -f $AssetID
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "PUT $Endpoint")) {

            $InvokeParams = @{             
                Endpoint   = $Endpoint
                Body       = $Body
            }
            New-ApiPUTRequest @InvokeParams
        }
    }
    End { }
}