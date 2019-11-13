Describe 'Get-SmaScriptTask Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            It 'should call only New-ApiGETRequest' {
                Get-SmaScriptTask -Id 1234

                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1

                $Methods = @('POST', 'DELETE', 'PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
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

