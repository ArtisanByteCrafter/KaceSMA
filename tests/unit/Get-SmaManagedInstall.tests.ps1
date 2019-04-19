$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'Get-SmaManagedInstall Unit Tests' -Tags 'Unit' {
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
                QueryParameters = "?paging=50"
            }

            $ManagedInstallIDParams = @{
                Server = 'https://foo'
                Credential = $MockCred
                Org = 'Default'
                ManagedInstallID = '1234'
                QueryParameters = "?paging=50"
            }

            Get-SmaManagedInstall @ManagedInstallIDParams

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call generic endpoint if ManagedInstallID parameter is not specified" {
                $Generic = $(Get-SmaManagedInstall @GenericParams -Verbose) 4>&1
                $Generic  | Should -Be 'Performing the operation "GET /api/managed_install/managed_installs" on target "https://foo".'
            }

            It "should call ManagedInstallID endpoint if ManagedInstallID parameter is specified" {
                $WithManagedInstallID = $(Get-SmaManagedInstall @ManagedInstallIDParams -Verbose) 4>&1
                $WithManagedInstallID  | Should -Be 'Performing the operation "GET /api/managed_install/managed_installs/1234" on target "https://foo".'
            }

            It "should call ListCompatibleMachines endpoint if ListCompatibleMachines parameter is specified" {
                $WithManagedInstallID = $(Get-SmaManagedInstall @ManagedInstallIDParams -Verbose) 4>&1
                $WithManagedInstallID  | Should -Be 'Performing the operation "GET /api/managed_install/managed_installs/1234" on target "https://foo".'
            }
        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{'Count'=1;'Warnings'=@{};'MIs'=@{}}
                return $MockResponse
            } -ModuleName KaceSMA

            $MockCred = New-Object System.Management.Automation.PSCredential ('fooUser', (ConvertTo-SecureString 'bar' -AsPlainText -Force))

            $GenericParams = @{
                Server = 'https://foo'
                Credential = $MockCred
                Org = 'Default'
                QueryParameters = "?paging=50"
            }

            It 'should produce [PSCustomObject] output' {

               $output = Get-SmaManagedInstall @GenericParams 
               $output | Should -Be "@{Count=1; Warnings=System.Collections.Hashtable; MIs=System.Collections.Hashtable}"
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }
        }
    }
} 

