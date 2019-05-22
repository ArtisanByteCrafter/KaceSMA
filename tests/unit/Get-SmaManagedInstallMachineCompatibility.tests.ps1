$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'Get-SmaManagedInstallMachineCompatibility Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $MockCred = New-Object System.Management.Automation.PSCredential ('fooUser', (ConvertTo-SecureString 'bar' -AsPlainText -Force))

            $MachineIDParams = @{
                Server = 'https://foo'
                Credential = $MockCred
                Org = 'Default'
                MachineID = '1234'
                QueryParameters = "?paging=50"
            }

            Get-SmaManagedInstallMachineCompatibility @MachineIDParams

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call MachineID endpoint if MachineID parameter is specified" {
                $WithMachineID = $(Get-SmaManagedInstallMachineCompatibility @MachineIDParams -Verbose) 4>&1
                $WithMachineID  | Should -Be 'Performing the operation "GET /api/managed_install/machines/1234" on target "https://foo".'
            }

        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{'Count'=1;'Warnings'=@{};'Machines'=@{}}
                return $MockResponse
            } -ModuleName KaceSMA

            $MockCred = New-Object System.Management.Automation.PSCredential ('fooUser', (ConvertTo-SecureString 'bar' -AsPlainText -Force))

            $MachineIDParams = @{
                Server = 'https://foo'
                Credential = $MockCred
                Org = 'Default'
                MachineID = '1234'
                QueryParameters = "?paging=50"
            }

            It 'should produce [PSCustomObject] output' {

               $output = Get-SmaManagedInstallMachineCompatibility @MachineIDParams 
               $output | Should -Be "@{Count=1; Warnings=System.Collections.Hashtable; Machines=System.Collections.Hashtable}"
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }
        }
    }
} 

