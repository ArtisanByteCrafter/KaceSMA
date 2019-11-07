$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'Get-SmaAsset Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $Server='https://foo'

            $GenericParams = @{
                QueryParameters = "?paging=50"
            }

            $AssetIDParams = @{
                AssetID = '1234'
                QueryParameters = "?paging=50"
            }

            $AsBarcodesParams = @{
                AssetID = '1234'
                AsBarcodes = $True
                QueryParameters = "?paging=50"
            }

            Get-SmaAsset @AssetIDParams

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call generic endpoint if AssetID parameter is NOT specified" {
                $Generic = $(Get-SmaAsset @GenericParams -Verbose) 4>&1
                $Generic  | Should -Be 'Performing the operation "GET /api/asset/assets" on target "https://foo".'
            }

            It "should call AssetID endpoint if AssetID parameter is specified" {
                $WithAssetID = $(Get-SmaAsset @AssetIDParams -Verbose) 4>&1
                $WithAssetID  | Should -Be 'Performing the operation "GET /api/asset/assets/1234" on target "https://foo".'
            }

            It "should call AsBarcodes endpoint if AsBarcodes parameter is specified" {
                $AsBarcodes = $(Get-SmaAsset @AsBarcodesParams -Verbose) 4>&1
                $AsBarcodes | Should -Be 'Performing the operation "GET /api/asset/assets/1234/barcodes" on target "https://foo".'
            }
        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{'Count'=1;'Warnings'=@{};'Assets'=@{}}
                return $MockResponse
            } -ModuleName KaceSMA

            $GenericParams = @{
                QueryParameters = "?paging=50"
            }

            It 'should produce [PSCustomObject] output' {

               $output = Get-SmaAsset @GenericParams 
               $output | Should -Be "@{Count=1; Warnings=System.Collections.Hashtable; Assets=System.Collections.Hashtable}"
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }
        }
    }
} 

