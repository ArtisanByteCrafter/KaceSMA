$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'Get-SmaServiceDeskTicketChanges Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $MockCred = New-Object System.Management.Automation.PSCredential ('fooUser', (ConvertTo-SecureString 'bar' -AsPlainText -Force))

            $TicketIDParams = @{
                Server = 'https://foo'
                Credential = $MockCred
                Org = 'Default'
                TicketID = 1234
            }


            Get-SmaServiceDeskTicketChanges @TicketIDParams

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call TicketID $($TicketIDParams.TicketID)/changes endpoint" {
                $WithTicketID = $(Get-SmaServiceDeskTicketChanges @TicketIDParams -Verbose) 4>&1
                $WithTicketID  | Should -Be 'Performing the operation "GET /api/service_desk/tickets/1234/changes" on target "https://foo".'
            }

        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{'count'=1;'warnings'=@{};'Changes'=@{}}
                return $MockResponse
            } -ModuleName KaceSMA

            $MockCred = New-Object System.Management.Automation.PSCredential ('fooUser', (ConvertTo-SecureString 'bar' -AsPlainText -Force))

            $TicketIDParams = @{
                Server = 'https://foo'
                Credential = $MockCred
                Org = 'Default'
                TicketID = 1234
            }

            It 'should produce [PSCustomObject] output' {
               $output = Get-SmaServiceDeskTicketChanges @TicketIDParams 
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }
        }
    }
} 