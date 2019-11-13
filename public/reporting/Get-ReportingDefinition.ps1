Function Get-ReportingDefinition {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low',
        DefaultParameterSetName = "Id"
    )]
    param(
        [Parameter(
            Position = 0,
            ParameterSetName = 'A',
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [Alias('DefinitionId')]
        [int]
        $Id,

        [Parameter(
            ParameterSetName = 'B',
            Position = 0,
            ValueFromPipelineByPropertyName
        )]
        [Alias('DefinitionName')]
        [string]
        $Name,

        [Parameter(
            ParameterSetName = 'C',
            Position = 0,
            ValueFromPipelineByPropertyName
        )]
        [Alias('DefinitionField')]
        [string]
        $Field,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin { }
    Process {
        $Endpoint = '/api/reporting/definitions'
        If ($Id) {
            $Endpoint = "/api/reporting/definitions/{0}" -f $Id
        }
        If ($Name) {
            $Endpoint = "/api/reporting/definitions/{0}" -f $Name
        }
        If ($Field) {
            $Endpoint = "/api/reporting/definitions/{0}" -f $Field
        }

        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            $newApiGETRequestSplat = @{
                QueryParameters = $QueryParameters
                Endpoint        = $Endpoint
            }
            $Result = New-ApiGETRequest @newApiGETRequestSplat
        }
    }
    End {
        $Result.Definitions
    }
}