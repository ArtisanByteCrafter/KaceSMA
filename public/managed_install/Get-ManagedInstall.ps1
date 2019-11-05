Function Get-ManagedInstall {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(
        [Parameter(Position = 0)]
        [int]
        $ManagedInstallID,

        [Parameter()]
        [switch]
        $ListCompatibleMachines,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin {
        $Endpoint = '/api/managed_install/managed_installs'
        If ($ManagedInstallID) {
            $Endpoint = "/api/managed_install/managed_installs/{0}" -f $ManagedInstallID
            If ($ListCompatibleMachines) {
                $Endpoint = "/api/managed_install/managed_installs/{0}/compatible_machines" -f $ManagedInstallID
            }
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