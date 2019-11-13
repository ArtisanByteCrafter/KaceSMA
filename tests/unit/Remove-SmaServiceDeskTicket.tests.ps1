Describe 'Remove-SmaServiceDeskTicket Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest { } -ModuleName KaceSMA
            Mock New-ApiPostRequest { } -ModuleName KaceSMA
            Mock New-ApiPutRequest { } -ModuleName KaceSMA
            Mock New-ApiDeleteRequest { } -ModuleName KaceSMA

            It 'should call only New-ApiDeleteRequest' {
                Remove-SmaServiceDeskTicket -Id 1234 -Confirm:$false

                Assert-MockCalled -CommandName New-ApiDeleteRequest -ModuleName KaceSMA -Times 1

                $Methods = @('GET', 'POST', 'PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }
        }
    }
} 