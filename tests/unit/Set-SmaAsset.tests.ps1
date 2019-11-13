Describe 'Set-SmaAsset Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            It 'should call only New-ApiPUTRequest' {
                $SetAssetBody = @{'foo' = 'foo' }
                $AssetIDParams = @{
                    ID = '1234'
                    Body = $SetAssetBody
                }
                Set-SmaAsset @AssetIDParams

                Assert-MockCalled -CommandName New-ApiPutRequest -ModuleName KaceSMA -Times 1

                $Methods = @('GET', 'DELETE', 'POST')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

        }

        Context 'Parameter input' {

            Mock New-ApiPUTRequest { } -ModuleName KaceSMA

            It "Should take parameter from pipeline" {
                {1234 | Set-SmaAsset -Body @{'foo' = 'foo' }} | Should -Not -Throw
            }

            It "Should take parameter from position" {
                {Set-SmaAsset -Id 1234 -Body @{'foo' = 'foo' }} | Should -Not -Throw
            }
        }
    }
} 

