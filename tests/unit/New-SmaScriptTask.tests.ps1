$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'New-SmaScriptTask Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $MockCred = New-Object System.Management.Automation.PSCredential ('fooUser', (ConvertTo-SecureString 'bar' -AsPlainText -Force))

            $Body = @{
                'attempts' = 2
                'onFailure' = 'break'
                'onRemediationFailure' = @(
                    @{
                        'id'= 27
                        'params'= [ordered]@{
                            'type'='status'
                            'message'='test remediation message2'
                        }
                    }
                )
            }

            $NewScriptTaskParams = @{
                Server = 'https://foo'
                Credential = $MockCred
                Org = 'Default'
                ScriptID = 1234
                Body = $Body
            }

            New-SmaScriptTask @NewScriptTaskParams

            It 'should call New-ApiPOSTRequest' {
                Assert-MockCalled -CommandName New-ApiPOSTRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('GET','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call '/api/script/{scriptID}/task' endpoint" {
                $WithBody = $(New-SmaScriptTask @NewScriptTaskParams -Verbose) 4>&1
                $WithBody  | Should -Be 'Performing the operation "POST /api/script/1234/task" on target "https://foo".'
            }
        }
    }
} 