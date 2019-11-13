Describe 'Invoke-SmaScript Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest { } -ModuleName KaceSMA
            Mock New-ApiPostRequest { } -ModuleName KaceSMA
            Mock New-ApiPutRequest { } -ModuleName KaceSMA
            Mock New-ApiDeleteRequest { } -ModuleName KaceSMA

            It 'should call only New-ApiPOSTRequest' {
                Invoke-SmaScript -Id 1234

                Assert-MockCalled -CommandName New-ApiPOSTRequest -ModuleName KaceSMA -Times 1

                $Methods = @('GET', 'DELETE', 'PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }
        }

        Context 'Parameter input' {

            Mock New-ApiPOSTRequest { } -ModuleName KaceSMA

            It "Should take -ID parameter from pipeline" {
                { 1234 | Invoke-SmaScript -TargetMachineID 1, 2 } | Should -Not -Throw
            }

            It "Should take -ID parameter from position" {
                { Invoke-SmaScript -Id 1234 -TargetMachineID 1, 2 } | Should -Not -Throw
            }
        }
    }
} 