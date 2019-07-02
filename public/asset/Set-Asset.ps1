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

    .NOTES
       
    #>
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'medium'
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
        [int]
        $AssetID,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body
    )
    Begin {
        $Endpoint = "/api/asset/assets/$AssetID"
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server,"PUT $Endpoint")) {

            $InvokeParams = @{
                Server = $Server
                Endpoint = $Endpoint
                Org = $Org
                Credential = $Credential
                Body = $Body
            }
            New-ApiPUTRequest @InvokeParams
        }
    }
    End {}
}