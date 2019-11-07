$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'Set-SmaAssetAsArchived Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $Server = 'https://foo'

            $Body = @{
                archiveReason = "Testing Archival via API"
            }
            
            $ArchiveSplat = @{
                AssetId = 1234
                Body = $Body
            }
            Set-SmaAssetAsArchived @ArchiveSplat

            It 'should call New-ApiPOSTRequest' {
                Assert-MockCalled -CommandName New-ApiPOSTRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('GET','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call '/api/asset/assets/1234/archive' endpoint" {
                $WithBody = $(Set-SmaAssetAsArchived @ArchiveSplat -Verbose) 4>&1
                $WithBody  | Should -Be 'Performing the operation "POST /api/asset/assets/1234/archive" on target "https://foo".'
            }
        }
    }
} 