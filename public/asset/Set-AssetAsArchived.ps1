Function Set-AssetAsArchived {
    <#
    .DESCRIPTION
        Archives an existing SMA asset.
      
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)


    .PARAMETER AssetID
        The ID of the asset you want to archive.
    
    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        $Body = @{
            @{ archiveReason = "Testing Archival via API" }
        }

        Set-SmaAssetAsArchived -Server https://kace.example.com -Org Default -Credential (Get-Credential) -AssetID 1234 -Body $Body

        Archives an asset with ID 1234 with the reason "Testing Archival via API"

    .NOTES
       
    #>
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
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
        $Endpoint = "/api/asset/assets/{0}/archive" -f $AssetID
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