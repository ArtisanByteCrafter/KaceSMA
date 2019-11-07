$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'Get-SmaScriptTask Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $Server = 'https://foo'

            $ScriptIDParams = @{
                ScriptID = 1234
            }

            $OrderIDParams = @{
                ScriptID = 1234
                OrderID = 1
            }

            Get-SmaScriptTask @ScriptIDParams

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call ScriptId endpoint if OrderID is not specified" {
                $WithScriptId = $(Get-SmaScriptTask @ScriptIDParams -Verbose) 4>&1
                $WithScriptId  | Should -Be 'Performing the operation "GET /api/script/1234/tasks" on target "https://foo".'
            }

            It "should call OrderId endpoint if OrderId is specified" {
                $WithOrderID = $(Get-SmaScriptTask @OrderIDParams -Verbose) 4>&1
                $WithOrderID  | Should -Be 'Performing the operation "GET /api/script/1234/task/1" on target "https://foo".'
            }
        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{'ordinalId'=0;'attempts'=1;'onFailure'='break'}
                return $MockResponse
            } -ModuleName KaceSMA

            $ScriptIDParams = @{
                ScriptID = 1234
            }

            It 'should produce [PSCustomObject] output' {
               $output = Get-SmaScriptTask @ScriptIDParams 
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }

            It 'should have valid NoteProperty values' {
                $NoteProperties = @('ordinalId','attempts','onFailure')
                $output = Get-SmaScriptTask @ScriptIDParams
                ($output | Get-Member -Type NoteProperty).Name | Should -BeIn $NoteProperties
            }

        }
    }
} 

