Describe 'Get-SmaServiceDeskQueueField Unit Tests' -Tags 'Unit' {
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


            Get-SmaServiceDeskQueueField @QueueIDParams

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call QueueID $($QueueIDParams.QueueID)/fields endpoint" {
                $WithQueueID = $(Get-SmaServiceDeskQueueField @QueueIDParams -Verbose) 4>&1
                $WithQueueID  | Should -Be 'Performing the operation "GET /api/service_desk/queues/1234/fields" on target "https://foo".'
            }

        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{'Fields'=@{'jsonKey'='title';'label'='Title';'column'='TITLE';'type'='text';'visible'='usercreate';'required'='all'}}
                return $MockResponse
            } -ModuleName KaceSMA

            $MockCred = New-Object System.Management.Automation.PSCredential ('fooUser', (ConvertTo-SecureString 'bar' -AsPlainText -Force))

            $QueueIDParams = @{
                QueueID = 1
            }

            It 'should produce [PSCustomObject] output' {
               $output = Get-SmaServiceDeskQueueField @QueueIDParams 
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }
        }
    }
} 

