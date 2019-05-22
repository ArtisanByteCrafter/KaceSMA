$root = Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent

$module = 'KaceSMA'

Describe "$module Module Tests" {
    Context 'Module Structure' {
        It "has root module named $module.psm1" {
            "$root\$module.psm1" | Should -Exist
        }

        It "has a manifest file of $module.psm1" {
            "$root\$module.psd1" | Should -Exist
            "$root\$module.psd1" | Should -FileContentMatch "RootModule = '$module.psm1'"
        }
    }
}
