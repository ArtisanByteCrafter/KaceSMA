$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'New-SmaServiceDeskTicket Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $MockCred = New-Object System.Management.Automation.PSCredential ('fooUser', (ConvertTo-SecureString 'bar' -AsPlainText -Force))

            $Body = @{
                'Tickets' =@(
                    @{
                    'title'='test-ticket'
                    'hd_queue_id'= 1
                    'submitter' = 1234
                    "custom_1" = 'custom field 1 text'
                    }
                )
            }

            $NewTicketParams = @{
                Server = 'https://foo'
                Credential = $MockCred
                Org = 'Default'
                Body = $Body
            }

            New-SmaServiceDeskTicket @NewTicketParams

            It 'should call New-ApiPOSTRequest' {
                Assert-MockCalled -CommandName New-ApiPOSTRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('GET','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call '/api/service_desk/tickets' endpoint" {
                $WithBody = $(New-SmaServiceDeskTicket @NewTicketParams -Verbose) 4>&1
                $WithBody  | Should -Be 'Performing the operation "POST /api/service_desk/tickets" on target "https://foo".'
            }
        }
    }
} 