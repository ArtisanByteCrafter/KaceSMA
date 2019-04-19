$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'Get-SmaScriptRunStatus Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $MockCred = New-Object System.Management.Automation.PSCredential ('fooUser', (ConvertTo-SecureString 'bar' -AsPlainText -Force))

            $RunIDParams = @{
                Server = 'https://foo'
                Credential = $MockCred
                Org = 'Default'
                RunID = 1234

            }

            Get-SmaScriptRunStatus @RunIDParams

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call RunID endpoint if MachineID parameter is not specified" {
                $RunID = $(Get-SmaScriptRunStatus @RunIDParams -Verbose) 4>&1
                $RunID  | Should -Be 'Performing the operation "GET /api/script/runstatus/1234" on target "https://foo".'
            }
        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{'scriptId'=1234;'Targeted'=@{};'Pending'=@{};'Success'=@{};'pushFailed'=@{};'failed'=@{}}
                return $MockResponse
            } -ModuleName KaceSMA

            $MockCred = New-Object System.Management.Automation.PSCredential ('fooUser', (ConvertTo-SecureString 'bar' -AsPlainText -Force))

            $RunIDParams = @{
                Server = 'https://foo'
                Credential = $MockCred
                Org = 'Default'
                RunID = 1234
            }

            It 'should produce [PSCustomObject] output' {
               $output = Get-SmaScriptRunStatus @RunIDParams 
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }

            It 'should have valid NoteProperty values' {
                $NoteProperties = @('failed','pending','pushFailed','scriptId','success','targeted')
                $output = Get-SmaScriptRunStatus @RunIDParams
                ($output | Get-Member -Type NoteProperty).Name | Should -BeIn $NoteProperties
            }

        }
    }
} 

