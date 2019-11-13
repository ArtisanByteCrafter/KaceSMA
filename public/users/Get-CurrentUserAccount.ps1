Function Get-CurrentUserAccount {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param( )
    Begin { }
    Process {
        $Endpoint = "/api/users/me"

        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            New-ApiGETRequest -Endpoint $Endpoint
        }
    }
    End { }
}