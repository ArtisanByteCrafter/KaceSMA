Describe 'Get-SmaMachineInventory Unit Tests' -Tags 'Unit' {
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

            $MachineIDParams = @{
                MachineID = '1234'
                QueryParameters = "?paging=50"
            }

            Get-SmaMachineInventory @MachineIDParams

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call generic endpoint if MachineID parameter is not specified" {
                $Generic = $(Get-SmaMachineInventory @GenericParams -Verbose) 4>&1
                $Generic  | Should -Be 'Performing the operation "GET /api/inventory/machines" on target "https://foo".'
            }

            It "should call MachineID endpoint if MachineID parameter is specified" {
                $WithMachineID = $(Get-SmaMachineInventory @MachineIDParams -Verbose) 4>&1
                $WithMachineID  | Should -Be 'Performing the operation "GET /api/inventory/machines/1234" on target "https://foo".'
            }
        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{'Count'=1;'Warnings'=@{};'Machines'=@{}}
                return $MockResponse
            } -ModuleName KaceSMA

            $GenericParams = @{
                QueryParameters = "?paging=50"
            }

            It 'should produce [PSCustomObject] output' {

               $output = Get-SmaMachineInventory @GenericParams 
               $output | Should -Be "@{Count=1; Warnings=System.Collections.Hashtable; Machines=System.Collections.Hashtable}"
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }
        }
    }
} 

