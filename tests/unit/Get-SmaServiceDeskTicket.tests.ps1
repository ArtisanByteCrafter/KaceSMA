Describe 'Get-SmaServiceDeskTicket Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $Server = 'https://foo'
            
            $TicketIDParams = @{
                TicketID = 1234
            }


            Get-SmaServiceDeskTicket

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }
            It "should call generic endpoint if -TicketID is not specified" {
                $WithoutTicketID = $(Get-SmaServiceDeskTicket -Verbose) 4>&1
                $WithoutTicketID  | Should -Be 'Performing the operation "GET /api/service_desk/tickets" on target "https://foo".'
            }

            It "should call TicketID $($TicketIDParams.TicketID)/fields endpoint if specified" {
                $WithTicketID = $(Get-SmaServiceDeskTicket @TicketIDParams -Verbose) 4>&1
                $WithTicketID  | Should -Be 'Performing the operation "GET /api/service_desk/tickets/1234" on target "https://foo".'
            }

        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{'count'=1;'warnings'=@{};'Tickets'=@{}}
                return $MockResponse
            } -ModuleName KaceSMA

            $TicketIDParams = @{
                TicketID = 1
            }

            It 'should produce [PSCustomObject] output' {
               $output = Get-SmaServiceDeskTicket @TicketIDParams 
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }
        }
    }
} 