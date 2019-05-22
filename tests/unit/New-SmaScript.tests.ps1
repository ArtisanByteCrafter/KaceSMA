$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'New-SmaScript Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $MockCred = New-Object System.Management.Automation.PSCredential ('fooUser', (ConvertTo-SecureString 'bar' -AsPlainText -Force))

            $Body = @{
                'name' = 'xMy New Script'
                'description' = 'This script is amazing.'
                'enabled' = $False
                'status' = 'Draft'
                'notes'='These are the notes'
                'scheduleType'='online-kscript'
                'alertEnabled' = $False
            }

            $NewScriptParams = @{
                Server = 'https://foo'
                Credential = $MockCred
                Org = 'Default'
                Body = $Body
            }

            New-SmaScript @NewScriptParams

            It 'should call New-ApiPOSTRequest' {
                Assert-MockCalled -CommandName New-ApiPOSTRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('GET','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call '/api/script' endpoint" {
                $WithBody = $(New-SmaScript @NewScriptParams -Verbose) 4>&1
                $WithBody  | Should -Be 'Performing the operation "POST /api/script" on target "https://foo".'
            }
        }
    }
} 