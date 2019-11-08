Describe 'Get-SmaBarcodeAsset Unit Tests' -Tags 'Unit' {
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

            $BarcodeIDParams = @{
                BarcodeID = 1234
                QueryParameters = "?paging=50"
            }

            Get-SmaBarcodeAsset @GenericParams

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It "should call generic endpoint" {
                $Generic = $(Get-SmaBarcodeAsset @GenericParams -Verbose) 4>&1
                $Generic  | Should -Be 'Performing the operation "GET /api/asset/barcodes" on target "https://foo".'
            }

            It "should call BarcodeID endpoint if BarcodeID parameter is specified" {
                $WithBarcodeID = $(Get-SmaBarcodeAsset @BarcodeIDParams -Verbose) 4>&1
                $WithBarcodeID  | Should -Be 'Performing the operation "GET /api/asset/barcodes/1234" on target "https://foo".'
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }
        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{'Count'=1;'Warnings'=@{};'Barcodes'=@{}}
                return $MockResponse
            } -ModuleName KaceSMA

            $GenericParams = @{
                QueryParameters = "?paging=50"
            }

            It 'should produce [PSCustomObject] output' {

               $output = Get-SmaBarcodeAsset @GenericParams 
               $output | Should -Be "@{Count=1; Warnings=System.Collections.Hashtable; Barcodes=System.Collections.Hashtable}"
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }
        }
    }
} 

