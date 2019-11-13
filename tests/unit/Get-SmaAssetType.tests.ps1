Describe 'Get-SmaAssetType Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest { } -ModuleName KaceSMA
            Mock New-ApiPostRequest { } -ModuleName KaceSMA
            Mock New-ApiPutRequest { } -ModuleName KaceSMA
            Mock New-ApiDeleteRequest { } -ModuleName KaceSMA

            It 'should call only New-ApiGETRequest' {
                Get-SmaAssetType -QueryParameters "?paging=50"
                
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1

                $Methods = @('POST', 'DELETE', 'PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }
        }
    }
} 

