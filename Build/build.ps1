param(
    [string[]]
    $Task = 'Default'
)

Get-PackageProvider -Name NuGet -ForceBootstrap > $null

$ModuleRoot = (Split-Path $PSScriptRoot -Parent)

Install-Module Psake,Pester -Scope CurrentUser -Force


Import-Module -Name Psake, (Join-Path $ModuleRoot KaceSma.psd1)

$invokePsakeSplat = @{
    TaskList  = $Task
    NoLogo    = $true
    BuildFile = "$PSScriptRoot/Psake.ps1"
}
Invoke-Psake @invokePsakeSplat

exit [int](-not $Psake.Build_Success)
