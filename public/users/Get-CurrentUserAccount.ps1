Function Get-CurrentUserAccount {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(

    )
    Begin {
        $Endpoint = "/api/users/me"
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            New-ApiGETRequest -Endpoint $Endpoint
        }
    }
    End { }
}