Describe 'Get-SmaScriptDependency Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $Server = 'https://foo'
            
            $ScriptIDParams = @{
                ScriptID = '1234'
            }

            $ScriptIDDependencyParams = @{
                ScriptID = '1234'
                DependencyName = 'foodependency'
            }

            Get-SmaScriptDependency @ScriptIDParams

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call ScriptID dependencies endpoint if no additional parameters are specified" {
                $Generic = $(Get-SmaScriptDependency @ScriptIDParams -Verbose) 4>&1
                $Generic  | Should -Be 'Performing the operation "GET /api/script/1234/dependencies" on target "https://foo".'
            }

            It "should call script DependencyName endpoint if DependencyName parameter is specified" {
                $WithScriptID = $(Get-SmaScriptDependency @ScriptIDDependencyParams -Verbose) 4>&1
                $WithScriptID  | Should -Be 'Performing the operation "GET /api/script/1234/dependency/foodependency" on target "https://foo".'
            }

            It 'should return empty if there are no dependencies' {
                Get-SmaScriptDependency @ScriptIDParams | Should -BeNullOrEmpty
            }
        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{
                    name = 'foo.bat'
                    checksum = 'abc123'
                }
                return $MockResponse
            } -ModuleName KaceSMA

            $MockCred = New-Object System.Management.Automation.PSCredential ('fooUser', (ConvertTo-SecureString 'bar' -AsPlainText -Force))

            $ScriptIDParams = @{
                ScriptID = '1234'
            }

            $ScriptIDDependencyParams = @{
                ScriptID = '1234'
                DependencyName = 'foodependency'
            }

            It 'should produce [PSCustomObject] output' {
               $output = Get-SmaScriptDependency @ScriptIDParams 
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }

            It 'should have valid NoteProperty values' {
                $NoteProperties = @('checksum','name')
                $output = Get-SmaScriptDependency @ScriptIDDependencyParams
                ($output | Get-Member -Type NoteProperty).Name | Should -Be $NoteProperties
            }
        }
    }
} 

