Function Get-Asset {
    <#
    .DESCRIPTION
        Returns information about an SMA asset.
      
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER AssetID
        (Optional) Use if you want to return a specific asset from the SMA.
        ID can be found in SMA Admin > Asset Management, then hover over an asset and look at the ID= in the url.
        This parameter is required if using the -AsBarcodes switch.

    .PARAMETER AsBarcodes
        (Optional) A switch where, if included, will return all barcodes associated with a specified asset (-AssetID parameter).
    
    .PARAMETER QueryParameters
        (Optional) Any additional query parameters to be included. String must begin with a <?> character.

    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        Get-SmaAsset -Server https://kace.example.com -Org Default -Credential (Get-Credential) -AssetID 1234

        Retrieves information about an asset with ID 1234.

    .EXAMPLE
        Get-SmaAsset -Server https://kace.example.com -Org Default -Credential (Get-Credential) -AssetID 5678 -AsBarcodes

        Retrieves barcode information about an asset with ID 5678.

    .NOTES
       
    #>
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(
        [Parameter()]
        [int]
        $AssetID,

        [Parameter()]
        [switch]
        $AsBarcodes,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin {
        $Endpoint = '/api/asset/assets'
        If ($AssetID) {
            $Endpoint = "/api/asset/assets/{0}" -f $AssetID
            If ($AsBarcodes) {
                $Endpoint = "/api/asset/assets/{0}/barcodes" -f $AssetID
            }
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