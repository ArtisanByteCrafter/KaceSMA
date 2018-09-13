Function Get-ReportingDefinition {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(
        [Parameter(Mandatory = $true)]
        [string]
        $Server,

        [Parameter(Mandatory = $true)]
        [string]
        $Org,

        [Parameter(Mandatory = $true)]
        [PSCredential]
        $Credential,

        [Parameter(ParameterSetName='A')]
        [int]
        $DefinitionID,

        [Parameter(ParameterSetName='B')]
        [string]
        $DefinitionName,

        [Parameter(ParameterSetName='C')]
        [string]
        $DistinctField,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin {
        $Endpoint = '/api/reporting/definitions/'
        If ($DefinitionID) {
            $Endpoint = "/api/reporting/definitions/$DefinitionID/"
        }
        If ($DefinitionName) {
            $Endpoint = "/api/reporting/definitions/$DefinitionName/"
        }
        If ($DistinctField) {
            $Endpoint = "/api/reporting/definitions/$DistinctField"
        }
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server)) {
            New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -QueryParameters $QueryParameters -Credential $Credential
        }
    }
    End {}
}