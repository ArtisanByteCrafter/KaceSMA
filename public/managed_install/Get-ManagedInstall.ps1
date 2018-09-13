Function Get-ManagedInstall {
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

        [Parameter()]
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
        $Endpoint = '/api/managed_install/managed_installs/'
        If ($ManagedInstallID) {
            $Endpoint = "/api/managed_install/managed_installs/$ManagedInstallID/"
            If ($ListCompatibleMachines) {
                $Endpoint = "/api/managed_install/managed_installs/$ManagedInstallID/compatible_machines"
            }
        }
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server)) {
            New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -QueryParameters $QueryParameters -Credential $Credential
        }
    }
    End {}
}