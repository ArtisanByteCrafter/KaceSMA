$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'Get-SmaScript Unit Tests' -Tags 'Unit' {
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

            $ScriptIDParams = @{
                ScriptID = '1234'
                QueryParameters = "?paging=50"
            }

            Get-SmaScript @ScriptIDParams

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call generic endpoint if no additional parameters are specified" {
                $Generic = $(Get-SmaScript @GenericParams -Verbose) 4>&1
                $Generic  | Should -Be 'Performing the operation "GET /api/scripts" on target "https://foo".'
            }

            It "should call ScriptID endpoint if ScriptID parameter is specified" {
                $WithScriptID = $(Get-SmaScript @ScriptIDParams -Verbose) 4>&1
                $WithScriptID  | Should -Be 'Performing the operation "GET /api/script/1234" on target "https://foo".'
            }
        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{
                    id = 1234
                    name = 'fooname'
                    type = 'policy'
                    scheduletype = 'online-shell'
                    status = 'Draft'
                    enabled = 'False'
                }
                return $MockResponse
            } -ModuleName KaceSMA

            
            $GenericParams = @{
                QueryParameters = "?paging=50"
            }

            $ScriptIDParams = @{
                ScriptID = '1234'
                QueryParameters = "?paging=50"
            }

            It 'should produce [PSCustomObject] output' {

               $output = Get-SmaScript @GenericParams 
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }

            It 'should have valid NoteProperty values' {
                $NoteProperties = @('id','name','type','scheduletype','status','enabled') # not an exhaustive list, but should give a good representation of a correct object type
                $output = Get-SmaScript @ScriptIDParams
                ($output | Get-Member -Type NoteProperty).Name | Should -BeIn $NoteProperties
            }
        }
    }
} 

