$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'Remove-SmaServiceDeskTicket Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest { } -ModuleName KaceSMA
            Mock New-ApiPostRequest { } -ModuleName KaceSMA
            Mock New-ApiPutRequest { } -ModuleName KaceSMA
            Mock New-ApiDeleteRequest { } -ModuleName KaceSMA

            $Server = 'https://foo'
            
            $RemoveTicketParams = @{
                TicketID = 1234
                Confirm  = $false
            }

            Remove-SmaServiceDeskTicket @RemoveTicketParams

            It 'should call New-ApiDELETERequest' {
                Assert-MockCalled -CommandName New-ApiDELETERequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('GET', 'POST', 'PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call '/api/service_desk/tickets/1234' endpoint" {
                $WithBody = $(Remove-SmaServiceDeskTicket @RemoveTicketParams -Verbose) 4>&1
                $WithBody | Should -Be 'Performing the operation "DELETE /api/service_desk/tickets/1234" on target "https://foo".'
            }
        }
    }
} 