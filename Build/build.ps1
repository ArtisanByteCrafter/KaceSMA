param(
    [string[]]
    $Task = 'Default'
)

Get-PackageProvider -Name NuGet -ForceBootstrap > $null

$ModuleRoot = (Split-Path $PSScriptRoot -Parent)

Install-Module Psake -Scope CurrentUser -Force

Import-Module -Name Psake, (Join-Path $ModuleRoot KaceSma.psd1)

Set-BuildEnvironment

$invokePsakeSplat = @{
    TaskList  = $Task
    NoLogo    = $true
    BuildFile = "$PSScriptRoot/Psake.ps1"
}
Invoke-Psake @invokePsakeSplat

exit [int](-not $Psake.Build_Success)
