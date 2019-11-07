$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'Get-SmaMachineService Unit Tests' -Tags 'Unit' {
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

            $ServiceIDParams = @{
                ServiceID = '1234'
                QueryParameters = "?paging=50"
            }

            Get-SmaMachineService @ServiceIDParams

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call generic endpoint if ServiceID parameter is not specified" {
                $Generic = $(Get-SmaMachineService @GenericParams -Verbose) 4>&1
                $Generic  | Should -Be 'Performing the operation "GET /api/inventory/services" on target "https://foo".'
            }

            It "should call ServiceID endpoint if ServiceID parameter is specified" {
                $WithServiceID = $(Get-SmaMachineService @ServiceIDParams -Verbose) 4>&1
                $WithServiceID  | Should -Be 'Performing the operation "GET /api/inventory/services/1234" on target "https://foo".'
            }
        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{'Count'=1;'Warnings'=@{};'Services'=@{}}
                return $MockResponse
            } -ModuleName KaceSMA

            $GenericParams = @{
                QueryParameters = "?paging=50"
            }

            It 'should produce [PSCustomObject] output' {

               $output = Get-SmaMachineService @GenericParams 
               $output | Should -Be "@{Count=1; Warnings=System.Collections.Hashtable; Services=System.Collections.Hashtable}"
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }
        }
    }
} 

