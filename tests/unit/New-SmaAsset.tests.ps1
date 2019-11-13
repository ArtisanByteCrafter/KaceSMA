Describe 'New-SmaAsset Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest { } -ModuleName KaceSMA
            Mock New-ApiPostRequest { } -ModuleName KaceSMA
            Mock New-ApiPutRequest { } -ModuleName KaceSMA
            Mock New-ApiDeleteRequest { } -ModuleName KaceSMA

            

            It 'should call only New-ApiPOSTRequest' {
                $NewAgentAsset = @{'foo' = 'foo' }
                New-SmaAsset -Body $NewAgentAsset

                Assert-MockCalled -CommandName New-ApiPostRequest -ModuleName KaceSMA -Times 1

                $Methods = @('GET', 'DELETE', 'PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }
        }

        Context 'Parameter input' {

            Mock New-ApiPOSTRequest { } -ModuleName KaceSMA

            $NewAgentAsset = @{'foo' = 'foo' }

            It "Should take parameter from pipeline" {
                { $NewAgentAsset | New-SmaAsset } | Should -Not -Throw
            }

            It "Should take parameter from position" {
                { New-SmaAsset -Body $NewAgentAsset } | Should -Not -Throw
            }
        }
    }
} 