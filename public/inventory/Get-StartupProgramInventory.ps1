Function Get-StartupProgramInventory {
    <#
    .DESCRIPTION
        Returns information about startup programs from SMA inventory devices, or for  specific startup program.
      
    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER ProgramID
        (Optional) Use if you want to return the information about a specific startup program.

    .PARAMETER QueryParameters
        (Optional) Any additional query parameters to be included. String must begin with a <?> character.

    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        Get-SmaStartupProgramInventory -Server https://kace.example.com -Org Default -Credential (Get-Credential)

        Retrieves information about all inventory devices' startup programs.
        
    .EXAMPLE
        Get-SmaStartupProgramInventory -Server https://kace.example.com -Org Default -Credential (Get-Credential) -ProgramID 1234

        Retrieves information for a startup program with ID 1234.

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
        $ProgramID,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin {
        $Endpoint = '/api/inventory/startup_programs/'
        If ($ProgramID) {
            $Endpoint = "/api/inventory/startup_programs/$ProgramID/"
        }
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server,"GET $Endpoint")) {
            New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -QueryParameters $QueryParameters -Credential $Credential
        }
    }
    End {}
}