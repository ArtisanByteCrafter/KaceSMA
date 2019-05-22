$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'Get-SmaCurrentUserAccount Unit Tests' -Tags 'Unit' {
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

            Get-SmaCurrentUserAccount @GenericParams

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
                $Generic = $(Get-SmaCurrentUserAccount @GenericParams -Verbose) 4>&1
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

            $MockCred = New-Object System.Management.Automation.PSCredential ('fooUser', (ConvertTo-SecureString 'bar' -AsPlainText -Force))

            $GenericParams = @{
                Server = 'https://foo'
                Credential = $MockCred
                Org = 'Default'
            }

            It 'should produce [PSCustomObject] output' {

               $output = Get-SmaCurrentUserAccount @GenericParams 
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }

            It 'should have valid NoteProperty values' {
                $NoteProperties = @(
                    'apiEnabled'
                    'canAddTickets'
                    'canAddTicketsUserPortal'
                    'currentOrgId'
                    'defaultQueueID'
                    'deviceScope'
                    'licensedFeatures'
                    'localTimezone'
                    'loggedin'
                    'loggedinEmail'
                    'loggedinFullName'
                    'loggedinID'
                    'orgs'
                    'permissions'
                    'RESTAPIVersion'
                    'serialNumber'
                    'supportAvailable'
                    'userID'
                    )
                $output = Get-SmaCurrentUserAccount @GenericParams
                ($output | Get-Member -Type NoteProperty).Name | Should -Be $NoteProperties
                ($output | Get-Member -Type NoteProperty).Count | Should -Be 18

            }
        }
    }
} 

