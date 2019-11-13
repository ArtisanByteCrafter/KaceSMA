Describe 'Set-SmaAssetAsArchived Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            It 'should call only New-ApiPOSTRequest' {
                $Body = @{
                    archiveReason = "Testing Archival via API"
                }
                
                $ArchiveSplat = @{
                    Id = 1234
                    Body = $Body
                }
                Set-SmaAssetAsArchived @ArchiveSplat

                Assert-MockCalled -CommandName New-ApiPostRequest -ModuleName KaceSMA -Times 1

                $Methods = @('GET', 'DELETE', 'PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            Context 'Parameter input' {

                Mock New-ApiPOSTRequest { } -ModuleName KaceSMA
    
                It "Should take parameter from pipeline" {
                    {1234 | Set-SmaAssetAsArchived -Body @{'foo' = 'foo' }} | Should -Not -Throw
                }
    
                It "Should take parameter from position" {
                    {Set-SmaAssetAsArchived -Body @{'foo' = 'foo' } -Id 1234} | Should -Not -Throw
                }
            }
        }
    }
} 