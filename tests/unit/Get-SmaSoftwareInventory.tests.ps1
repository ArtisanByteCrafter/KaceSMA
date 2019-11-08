Describe 'Get-SmaSoftwareInventory Unit Tests' -Tags 'Unit' {
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

            $SoftwareIDParams = @{
                SoftwareID = 1234
            }


            Get-SmaSoftwareInventory @SoftwareIDParams

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call generic endpoint if SoftwareID is not defined." {
                $Generic = $(Get-SmaSoftwareInventory @GenericParams -Verbose) 4>&1
                $Generic  | Should -Be 'Performing the operation "GET /api/inventory/softwares" on target "https://foo".'
            }
            It "should call SoftwareID $($SoftwareIDParams.SoftwareID)/changes endpoint" {
                $WithSoftwareID = $(Get-SmaSoftwareInventory @SoftwareIDParams -Verbose) 4>&1
                $WithSoftwareID  | Should -Be 'Performing the operation "GET /api/inventory/softwares/1234" on target "https://foo".'
            }

        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{'Tickets'=@{}}
                return $MockResponse
            } -ModuleName KaceSMA

            $MockCred = New-Object System.Management.Automation.PSCredential ('fooUser', (ConvertTo-SecureString 'bar' -AsPlainText -Force))

            $SoftwareIDParams = @{
                SoftwareID = 1234
            }

            It 'should produce [PSCustomObject] output' {
               $output = Get-SmaSoftwareInventory @SoftwareIDParams 
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }
        }
    }
} 