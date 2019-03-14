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
            archiveReason = "Testing Archival via API"
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
        $Endpoint = "/api/asset/assets/$AssetID/archive"
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server,"POST $Endpoint")) {
            New-ApiPOSTRequest -Server $Server -Endpoint $Endpoint -Org $Org -Credential $Credential -Body $Body
        }
    }
    End {}
}