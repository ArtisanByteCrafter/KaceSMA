Function Get-ReportingDefinition {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low',
        DefaultParameterSetName = "DefinitionID"
    )]
    param(
        [Parameter(ParameterSetName = 'A',Position = 0)]
        [int]
        $DefinitionID,

        [Parameter(ParameterSetName = 'B',Position = 0)]
        [string]
        $DefinitionName,

        [Parameter(ParameterSetName = 'C',Position = 0)]
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