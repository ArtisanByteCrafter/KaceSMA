Describe 'Get-SmaCurrentUserAccount Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $Server = 'https://foo'
            Get-SmaCurrentUserAccount

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call generic endpoint" {
                $Generic = $(Get-SmaCurrentUserAccount -Verbose) 4>&1
                $Generic  | Should -Be 'Performing the operation "GET /api/users/me" on target "https://foo".'
            }
        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{
                    userId = ''
                    permissions = @{}
                    canAddTickets = 'True'
                    canAddTicketsUserPortal = 'True'
                    licensedFeatures = @{}
                    supportAvailable = 1
                    deviceScope = @{}
                    loggedin = ''
                    loggedinId = 1
                    loggedinEmail = ''
                    loggedinFullName = ''
                    orgs = @{}
                    currentOrgId = @{}
                    serialNumber = ''
                    localTimezone = ''
                    RESTAPIVersion = 1
                    defaultQueueID = 0
                    apiEnabled = 1
                }
                return $MockResponse
            } -ModuleName KaceSMA

            It 'should produce [PSCustomObject] output' {

               $output = Get-SmaCurrentUserAccount 
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }
        }
    }
} 

