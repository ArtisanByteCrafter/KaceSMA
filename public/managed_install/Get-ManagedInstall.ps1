Function Get-ManagedInstall {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'low'
    )]
    param(
        [Parameter(
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [Alias('ManagedInstallId')]
        [int]
        $Id,

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
        
        If ($Id) {
            $Endpoint = "/api/managed_install/managed_installs/{0}" -f $Id
            If ($ListCompatibleMachines) {
                $Endpoint = "/api/managed_install/managed_installs/{0}/compatible_machines" -f $Id
            }
        }
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "GET $Endpoint")) {
            $newApiGETRequestSplat = @{
                QueryParameters = $QueryParameters
                Endpoint        = $Endpoint
            }
            $Result = New-ApiGETRequest @newApiGETRequestSplat
        }
    }
    End {
        $Result.MIs
    }
}