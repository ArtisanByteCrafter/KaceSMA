Function Get-ManagedInstallMachineCompatibility {
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

        [Parameter(Mandatory = $true)]
        [int]
        $MachineID,

        [Parameter()]
        [ValidatePattern("^\?")]
        [string]
        $QueryParameters
    )
    Begin {
        $Endpoint = "/api/managed_install/machines/$MachineID/"
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server)) {
            New-ApiGETRequest -Server $Server -Endpoint $Endpoint -Org $Org -QueryParameters $QueryParameters -Credential $Credential
        }
    }
    End {}
}