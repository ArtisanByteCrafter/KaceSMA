$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'Get-SmaAgentlessInventory Unit Tests' -Tags 'Unit' {
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

            $NodesIDParams = @{
                Server = 'https://foo'
                Credential = $MockCred
                Org = 'Default'
                NodesID = '1234'
                QueryParameters = "?paging=50"
            }

            Get-SmaAgentlessInventory @NodesIDParams

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call generic endpoint if NodesID parameter is not specified" {
                $Generic = $(Get-SmaAgentlessInventory @GenericParams -Verbose) 4>&1
                $Generic  | Should -Be 'Performing the operation "GET /api/inventory/nodes" on target "https://foo".'
            }

            It "should call NodesID endpoint if NodesID parameter is specified" {
                $WithNodesID = $(Get-SmaAgentlessInventory @NodesIDParams -Verbose) 4>&1
                $WithNodesID  | Should -Be 'Performing the operation "GET /api/inventory/nodes/1234" on target "https://foo".'
            }
        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{'Count'=1;'Warnings'=@{};'Machines'=@{}}
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

               $output = Get-SmaAgentlessInventory @GenericParams 
               $output | Should -Be "@{Count=1; Warnings=System.Collections.Hashtable; Machines=System.Collections.Hashtable}"
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }
        }
    }
} 

