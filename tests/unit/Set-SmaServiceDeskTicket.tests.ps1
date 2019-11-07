$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'Set-SmaServiceDeskTicket Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $Server = 'https://foo'

            $Body = @{
                'Tickets' = @(
                    @{
                        'custom_1' = "text for custom_1"
                        'custom_2' = "text for custom_2"
                    }
                )
            }
            
            $TicketSplat = @{
                TicketId = 1234
                Body = $Body
            }
            Set-SmaServiceDeskTicket @TicketSplat

            It 'should call New-ApiPUTRequest' {
                Assert-MockCalled -CommandName New-ApiPUTRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('GET','DELETE','POST')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call '/api/service_desk/tickets/1234' endpoint" {
                $WithBody = $(Set-SmaServiceDeskTicket @TicketSplat -Verbose) 4>&1
                $WithBody  | Should -Be 'Performing the operation "PUT /api/service_desk/tickets/1234" on target "https://foo".'
            }
        }
    }
} 