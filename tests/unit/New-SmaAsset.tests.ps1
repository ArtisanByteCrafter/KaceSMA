Describe 'New-SmaAsset Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $Server = 'https://foo'
            
            $NewAgentAsset = @{
                'Assets' =@(
                    @{
                    'name'='testAsset'
                    "asset_type_id" = 5
                    'location_id' = 7080
                    'asset_type_name' = "Computer with Dell Agent"
                    }
                )
            }

            $BodyParams = @{
                Body = $NewAgentAsset
            }

            New-SmaAsset @BodyParams

            It 'should call New-ApiPOSTRequest' {
                Assert-MockCalled -CommandName New-ApiPOSTRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('GET','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call '/api/asset/assets' endpoint" {
                $WithBody = $(New-SmaAsset @BodyParams -Verbose) 4>&1
                $WithBody  | Should -Be 'Performing the operation "POST /api/asset/assets" on target "https://foo".'
            }
        }

        Context 'Function Output' {
            Mock New-ApiPostRequest {
                $MockResponse = [PSCustomObject]@{'Result'='Success'}
                return $MockResponse
            } -ModuleName KaceSMA

            $MockCred = New-Object System.Management.Automation.PSCredential ('fooUser', (ConvertTo-SecureString 'bar' -AsPlainText -Force))

            $NewAgentAsset = @{
                'Assets' =@(
                    @{
                    'name'='testAssetFoo'
                    "asset_type_id" = 5
                    'location_id' = 7080
                    'asset_type_name' = "Computer with Dell Agent"
                    }
                )
            }
            $BodyParams = @{
                Body = $NewAgentAsset
            }

            It 'should produce PSCustomObject output' {
               $output = New-SmaAsset @BodyParams 
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }
        }
    }
} 