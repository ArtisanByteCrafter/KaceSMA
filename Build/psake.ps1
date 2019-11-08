Task 'Default' -Depends 'Pester'

Task 'Init' {
    $ModuleRoot = (Split-Path $PSScriptRoot -Parent)

    Import-Module -Name Psake, BuildHelpers, (Join-Path $ModuleRoot KaceSma.psd1)
   
}


task 'Pester' -depends 'Init' {
    $Timestamp = Get-Date -Format "yyyyMMdd-hhmmss"
    $PSVersion = $PSVersionTable.PSVersion.Major
    
    $TestFile = "PSv${PSVersion}_${TimeStamp}_KaceSMA.TestResults.xml"

    $PesterParams = @{
        Path                   = (Join-Path (Split-Path $PSScriptRoot -Parent) 'tests')
        PassThru               = $true
        OutputFormat           = 'NUnitXml'
        OutputFile             = (Join-Path $env:BHBuildOutput $TestFile)
        Show                   = "Header", "Failed", "Summary"
    }

    $TestResults = Invoke-Pester @PesterParams # -Script (Join-Path (Split-Path $PSScriptRoot -Parent) 'tests')

    if ($TestResults.FailedCount -gt 0) {
        Write-Error "Failed $($TestResults.FailedCount) tests; build failed!"
    }
}