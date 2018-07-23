
$Public  = Get-ChildItem $PSScriptRoot\public\*.ps1 -Recurse -ErrorAction SilentlyContinue
$Private = Get-ChildItem $PSScriptRoot\private\*.ps1 -Recurse -ErrorAction SilentlyContinue


Foreach($import in @($Public + $Private)) {
    Try {
        . $import.fullname
    }
    Catch {
        Write-Error "Failed to import function $($import.fullname)"
    }
}

#Export-ModuleMember -function (Get-ChildItem -Path "$PSScriptRoot\public\*.ps1" -Recurse).basename