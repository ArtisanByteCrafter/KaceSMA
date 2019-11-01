Function Get-UserPermissions {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(
        [Parameter(Mandatory)]
        [string]
        $UserID,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters

    )
    Begin {
        $Endpoint = "/api/users/{0}/permissions" -f $UserID
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