Function Get-ReportingDefinition {
    <#
      .DESCRIPTION
        //todo

    .PARAMETER Server
        The fully qualified name (FQDN) of the SMA Appliance.
        Example: https://kace.example.com

    .PARAMETER Org
        The SMA Organization you want to retrieve information from. If not provided, 'Default' is used.
    
    .PARAMETER Credential
        A credential for the kace appliance that has permissions to interact with the API.
        To run interactively, use -Credential (Get-Credential)

    .PARAMETER DefinitionID
        //todo
    .PARAMETER DefinitionName
        //todo
    .PARAMETER DistinctField
       //todo

    .PARAMETER QueryParameters
        (Optional) Any additional query parameters to be included. String must begin with a <?> character.

    .INPUTS

    .OUTPUTS
        PSCustomObject

    .EXAMPLE
        This will return the reporting definitions for report ID 1234 in ORG 1.

        Get-SmaReportingDefinition -Server https://kace.example.com -Credential (Get-Credential) -DefinitionID 1234 -QueryParameters "?orgID=1"
        
    .EXAMPLE
        //todo

    .NOTES
       
    #>
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low',
        DefaultParameterSetName = "DefinitionID"
    )]
    param(
        [Parameter(ParameterSetName = 'A')]
        [int]
        $DefinitionID,

        [Parameter(ParameterSetName = 'B')]
        [string]
        $DefinitionName,

        [Parameter(ParameterSetName = 'C')]
        [string]
        $DistinctField,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin {
        $Endpoint = '/api/reporting/definitions'
        If ($DefinitionID) {
            $Endpoint = "/api/reporting/definitions/{0}" -f $DefinitionID
        }
        If ($DefinitionName) {
            $Endpoint = "/api/reporting/definitions/{0}" -f $DefinitionName
        }
        If ($DistinctField) {
            $Endpoint = "/api/reporting/definitions/{0}" -f $DistinctField
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