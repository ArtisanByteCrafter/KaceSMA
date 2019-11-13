Describe 'Get-SmaScriptDependency Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            It 'should call only New-ApiGETRequest' {
                Get-SmaScriptDependency -Id 1234

                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1

                $Methods = @('POST', 'DELETE', 'PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }
        }

        Context 'Parameter input' {

            Mock New-ApiGetRequest { } -ModuleName KaceSMA

            It "Should take parameter from pipeline" {
                {1234 | Get-SmaScriptDependency} | Should -Not -Throw
            }

            It "Should take parameter from position" {
                {Get-SmaScriptDependency -Id 1234} | Should -Not -Throw
            }
        }
    }
} 

