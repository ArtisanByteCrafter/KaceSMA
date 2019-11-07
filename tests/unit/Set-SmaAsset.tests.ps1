$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'Set-SmaAsset Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $Server = 'https://foo'
            
            $SetAssetBody = @{
                'Assets' = @(
                    @{
                        'id'          = 7563
                        'field_10149' = 'nwtest2'
                    }
                )
            }

            $AssetIDParams = @{
                AssetID = '1234'
                Body = $SetAssetBody
            }


            Set-SmaAsset @AssetIDParams

            It 'should call New-ApiPUTRequest' {
                Assert-MockCalled -CommandName New-ApiPUTRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','GET')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call AssetID endpoint" {
                $WithAssetID = $(Set-SmaAsset @AssetIDParams -Verbose) 4>&1
                $WithAssetID  | Should -Be 'Performing the operation "PUT /api/asset/assets/1234" on target "https://foo".'
            }

        }

        Context 'Function Output' {
            Mock New-ApiPUTRequest {
                $MockResponse = [pscustomobject]@{'Result'='Success'}
                return $MockResponse
            } -ModuleName KaceSMA

            $MockCred = New-Object System.Management.Automation.PSCredential ('fooUser', (ConvertTo-SecureString 'bar' -AsPlainText -Force))

           

            It 'should produce [PSCustomObject] output' {

                $SetAssetBody = @{
                    'Assets' = @(
                        @{
                            'id'          = 7563
                            'field_10149' = 'nwtest2'
                        }
                    )
                }

                $AssetIDParams = @{
                    AssetID = '1234'
                    Body = $SetAssetBody
                }

               $output = Set-SmaAsset @AssetIDParams 

               $output | Should -BeOfType PSCustomObject
            }
        }
    }
} 

