$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'Get-SmaUserPermissions Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $Server = 'https://foo'

            $UserIDParams = @{
                UserID = 1234
            }

            Get-SmaUserPermissions @UserIDParams

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call UserID $($UserIDParams.UserID)/permissions endpoint" {
                $WithUserID = $(Get-SmaUserPermissions @UserIDParams -Verbose) 4>&1
                $WithUserID  | Should -Be 'Performing the operation "GET /api/users/1234/permissions" on target "https://foo".'
            }

        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{
                    'userId' = 1
                    'Permissions'=@{}
                    'canAddTickets'='True'
                    'canAddTicketsUserPortal' = 'True'
                    'licensedFeatures' = @{}
                    'supportAvailable'=1
                    'deviceScope'=@{}
                }
                return $MockResponse
            } -ModuleName KaceSMA

            $UserIDParams = @{
                UserID = 1234
            }

            It 'should produce [PSCustomObject] output' {
               $output = Get-SmaUserPermissions @UserIDParams 
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }
        }
    }
} 