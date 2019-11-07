$root = Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent

$FunctionsToExport = @(
    'Get-MachineInventory'
    'Get-CurrentUserAccount'
    'Get-UserPermissions'
    'Get-AgentlessInventory'
    'Get-OperatingSystemInventory'
    'Get-MachineProcess'
    'Get-MachineService'
    'Get-SoftwareInventory'
    'Get-StartupProgramInventory'
    'Get-Asset'
    'Get-AssetType'
    'Get-BarcodeAsset'
    'Get-ManagedInstall'
    'Get-ManagedInstallMachineCompatibility'
    'Get-ReportingDefinition'
    'Get-ScriptRunStatus'
    'Get-Script'
    'Get-ScriptDependency'
    'Get-ScriptTask'
    'New-Asset'
    'New-Script'
    'New-ScriptTask'
    'Invoke-Script'
    'Get-ArchiveAsset'
    'Set-AssetAsArchived'
    'Get-ServiceDeskQueue'
    'Get-ServiceDeskQueueField'
    'Get-ServiceDeskTicketTemplate'
    'Get-ServiceDeskTicket'
    'New-ServiceDeskTicket'
    'Set-MachineInventory'
    'Set-ServiceDeskTicket'
    'Remove-ServiceDeskTicket'
    'Get-ServiceDeskTicketChanges'
    'Set-Asset'
)

Describe "General Function Tests" {
    Foreach ($function in $FunctionsToExport) {
        Context "$function has valid structure" {
        
        
            It "PUBLIC function $function.ps1 should exist" {
                "$root\public\*\$function.ps1" | Should -Exist
            }

            It "$function.ps1 is valid Powershell code" {
                $psFile = Get-Content -Path "$root\public\*\$function.ps1" -ErrorAction Stop
                $errors = $null
                $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
                $errors.Count | Should Be 0
            }
        }
    }
}