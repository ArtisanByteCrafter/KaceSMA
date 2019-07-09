
$Public  = Get-ChildItem $PSScriptRoot\public\*.ps1 -Recurse -ErrorAction SilentlyContinue
$Private = Get-ChildItem $PSScriptRoot\private\*.ps1 -Recurse -ErrorAction SilentlyContinue

Foreach($import in @($Public + $Private)) { . $import.fullname }