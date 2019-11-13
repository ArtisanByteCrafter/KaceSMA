Describe 'New-SmaScriptTask Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest { } -ModuleName KaceSMA
            Mock New-ApiPostRequest { } -ModuleName KaceSMA
            Mock New-ApiPutRequest { } -ModuleName KaceSMA
            Mock New-ApiDeleteRequest { } -ModuleName KaceSMA

            It 'should call only New-ApiPOSTRequest' {
                $Body = @{
                    'attempts'             = 2
                    'onFailure'            = 'break'
                    'onRemediationFailure' = @(
                        @{
                            'id'     = 27
                            'params' = [ordered]@{
                                'type'    = 'status'
                                'message' = 'test remediation message2'
                            }
                        }
                    )
                }

                $NewScriptTaskParams = @{
                    ID   = 1234
                    Body = $Body
                }
    
                New-SmaScriptTask @NewScriptTaskParams

                Assert-MockCalled -CommandName New-ApiPostRequest -ModuleName KaceSMA -Times 1

                $Methods = @('GET', 'DELETE', 'PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }
        }

        Context 'Parameter input' {

            Mock New-ApiPOSTRequest { } -ModuleName KaceSMA

            It "Should take parameter from pipeline" {
                { 1234 | New-SmaScriptTask -Body @{'foo' = 'foo' } } | Should -Not -Throw
            }

            It "Should take parameter from position" {
                { New-SmaScriptTask -Id 1234 -Body @{'foo' = 'foo' } } | Should -Not -Throw
            }
        }

    }
} 