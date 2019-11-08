Describe 'Get-SmaServiceDeskTicketTemplate Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $Server = 'https://foo'

            $QueueIDParams = @{
                QueueID = 1234
            }


            Get-SmaServiceDeskTicketTemplate @QueueIDParams

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call QueueID $($QueueIDParams.QueueID)/ticket_template endpoint" {
                $WithQueueID = $(Get-SmaServiceDeskTicketTemplate @QueueIDParams -Verbose) 4>&1
                $WithQueueID  | Should -Be 'Performing the operation "GET /api/service_desk/queues/1234/ticket_template" on target "https://foo".'
            }

        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{'Tickets'=@{}}
                return $MockResponse
            } -ModuleName KaceSMA

            $QueueIDParams = @{
                QueueID = 1234
            }

            It 'should produce [PSCustomObject] output' {
               $output = Get-SmaServiceDeskTicketTemplate @QueueIDParams 
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }
        }
    }
} 