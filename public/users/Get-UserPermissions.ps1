Function Get-UserPermissions {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(
        [Parameter(
            Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [Alias('AssetId')]
        [int]
        $Id,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters

    )
    Begin {
        
    }
    Process {
        $Endpoint = "/api/users/{0}/permissions" -f $Id

        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            $newApiGETRequestSplat = @{
                QueryParameters = $QueryParameters
                Endpoint        = $Endpoint
            }
            $Result = New-ApiGETRequest @newApiGETRequestSplat
        }
    }
    End {
        $Result
    }
}