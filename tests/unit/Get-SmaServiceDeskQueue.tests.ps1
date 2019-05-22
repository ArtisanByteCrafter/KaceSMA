$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'Get-SmaServiceDeskQueue Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $MockCred = New-Object System.Management.Automation.PSCredential ('fooUser', (ConvertTo-SecureString 'bar' -AsPlainText -Force))

            $GenericParams = @{
                Server = 'https://foo'
                Credential = $MockCred
                Org = 'Default'
            }

            $QueueIDParams = @{
                Server = 'https://foo'
                Credential = $MockCred
                Org = 'Default'
                QueueID = 1
            }


            Get-SmaServiceDeskQueue @GenericParams

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call generic endpoint if -QueueID is not specified" {
                $WithQueueID = $(Get-SmaServiceDeskQueue @GenericParams -Verbose) 4>&1
                $WithQueueID  | Should -Be 'Performing the operation "GET /api/service_desk/queues" on target "https://foo".'
            }

            It "should call QueueID endpoint if -QueueID is specified" {
                $WithQueueID = $(Get-SmaServiceDeskQueue @QueueIDParams -Verbose) 4>&1
                $WithQueueID  | Should -Be 'Performing the operation "GET /api/service_desk/queues/1" on target "https://foo".'
            }
        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{'count'=1;'Warnings'=@{};'Queues'=@{}}
                return $MockResponse
            } -ModuleName KaceSMA

            $MockCred = New-Object System.Management.Automation.PSCredential ('fooUser', (ConvertTo-SecureString 'bar' -AsPlainText -Force))

            $QueueIDParams = @{
                Server = 'https://foo'
                Credential = $MockCred
                Org = 'Default'
                QueueID = 1
            }

            It 'should produce [PSCustomObject] output' {
               $output = Get-SmaServiceDeskQueue @QueueIDParams 
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }

            If ($QueueIdParams.QueueId) {
                It 'Specifying -QueueID should only return count of 1' {
                    # this will always return true due to the mock response being hard coded to 1.
                    # It is provided as a basis for integration tests if desired.
                    $output = Get-SmaServiceDeskQueue @QueueIDParams 
                    $output.Count | Should -Be 1
                 }
            }
        }
    }
} 

