Function Get-SoftwareInventory {
    <#
    .DESCRIPTION
        Returns information about SMA software titles, or for  specific software title.
      
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER SoftwareID
        (Optional) Use if you want to return information about a specific software title.

    .PARAMETER QueryParameters
        (Optional) Any additional query parameters to be included. String must begin with a <?> character.

    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        Get-SmaSoftwareInventory -Server https://kace.example.com -Org Default -Credential (Get-Credential)

        Retrieves information about all software titles in the SMA.
        
    .EXAMPLE
        Get-SmaSoftwareInventory -Server https://kace.example.com -Org Default -Credential (Get-Credential) -SoftwareID 1234

        Retrieves information for a software title with ID 1234.

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
        [string]
        $SoftwareID,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )

    Begin {
        $Endpoint = '/api/inventory/softwares/'
        If ($SoftwareID) {
            $Endpoint = "/api/inventory/softwares/$SoftwareID/"
        }
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server)) {
            New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -QueryParameters $QueryParameters -Credential $Credential
        }
    }
    End {}
}