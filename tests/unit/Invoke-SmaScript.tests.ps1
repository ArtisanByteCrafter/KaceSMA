$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'Invoke-SmaScript Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $Server = 'https://foo'

            $ScriptIDParams = @{
                ScriptID = 1234
                TargetMachineId=1,2
            }

            Invoke-SmaScript @ScriptIDParams

            It 'should call New-ApiPOSTRequest' {
                Assert-MockCalled -CommandName New-ApiPOSTRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('GET','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call '/api/script/$($ScriptIDParams.ScriptID)/actions/run' endpoint" {
                $WithScriptID = $(Invoke-SmaScript @ScriptIDParams -Verbose) 4>&1
                $WithScriptID  | Should -Be 'Performing the operation "POST /api/script/1234/actions/run" on target "https://foo".'
            }
        }

        Context 'Function Output' {
            Mock New-ApiPostRequest {
                $MockResponse = [int32] 5555
                return $MockResponse
            } -ModuleName KaceSMA

            $ScriptIDParams = @{
                ScriptID = 1234
                TargetMachineId=1,2
            }

            It 'should produce Int32 output' {
               $output = Invoke-SmaScript @ScriptIDParams
               $output | Should -BeOfType Int32
            }
        }
    }
} 