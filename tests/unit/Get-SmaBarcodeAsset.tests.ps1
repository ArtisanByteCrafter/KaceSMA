Describe 'Get-SmaBarcodeAsset Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            Get-SmaBarcodeAsset -QueryParameters "?paging=50"

            It 'should call only New-ApiGETRequest' {
                Get-SmaAsset -Id 1234 -QueryParameters "?paging=50"

                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1

                $Methods = @('POST', 'DELETE', 'PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }
        }

        Context 'Parameter input' {

            # Mock a return object from the SMA with a single property, Id
            Mock New-ApiGetRequest { } -ModuleName KaceSMA

            It "Should take parameter from pipeline" {
                {1234 | Get-SmaBarcodeAsset} | Should -Not -Throw
            }

            It "Should take parameter from position" {
                {Get-SmaBarcodeAsset -Id 1234} | Should -Not -Throw
            }
        }
    }
} 

