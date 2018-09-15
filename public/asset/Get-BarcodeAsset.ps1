Function Get-BarcodeAsset {
     <#
    .DESCRIPTION
        Returns information about an SMA barcode.
      
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER BarcodeID
        (Optional) Use if you want to return a specific barcode from the SMA.

    .PARAMETER QueryParameters
        (Optional) Any additional query parameters to be included. String must begin with a <?> character.
        
    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        Get-SmaBarcodeAsset -Server https://kace.example.com -Org Default -Credential (Get-Credential) -BarcodeID 1234

        Retrieves information about a barcode with ID 1234.

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

        [Parameter()]
        [int]
        $BarcodeID,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin {
        $Endpoint = '/api/asset/barcodes'
        If ($BarcodeID) {
            $Endpoint = "/api/asset/barcodes/$BarcodeID/"
        }
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server)) {
            New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -QueryParameters $QueryParameters -Credential $Credential
        }
    }
    End {}
}