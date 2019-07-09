$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'Get-SmaReportingDefinition Unit Tests' -Tags 'Unit' {
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
                QueryParameters = "?orgID=1"
            }

            $DefinitionIDParams = @{
                Server = 'https://foo'
                Credential = $MockCred
                Org = 'Default'
                DefinitionID = '1234'
                QueryParameters = "?orgID=1"
            }

            $DefinitionNameParams = @{
                Server = 'https://foo'
                Credential = $MockCred
                Org = 'Default'
                DefinitionName = 'fooname'
                QueryParameters = "?orgID=1"
            }

            $DistinctFieldParams = @{
                Server = 'https://foo'
                Credential = $MockCred
                Org = 'Default'
                DistinctField = 'foofield'
                QueryParameters = "?orgID=1"
            }

            Get-SmaReportingDefinition @DefinitionIDParams

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call generic endpoint if no additional parameters are specified" {
                $Generic = $(Get-SmaReportingDefinition @GenericParams -Verbose) 4>&1
                $Generic  | Should -Be 'Performing the operation "GET /api/reporting/definitions" on target "https://foo".'
            }

            It "should call DefinitionID endpoint if DefinitionID parameter is specified" {
                $WithDefinitionID = $(Get-SmaReportingDefinition @DefinitionIDParams -Verbose) 4>&1
                $WithDefinitionID  | Should -Be 'Performing the operation "GET /api/reporting/definitions/1234" on target "https://foo".'
            }

            It "should call DefinitionName endpoint if DefinitionName parameter is specified" {
                $WithDefinitionName = $(Get-SmaReportingDefinition @DefinitionNameParams -Verbose) 4>&1
                $WithDefinitionName  | Should -Be 'Performing the operation "GET /api/reporting/definitions/fooname" on target "https://foo".'
            }

            It "should call DistinctField endpoint if DistinctField parameter is specified" {
                $WithDistinctField = $(Get-SmaReportingDefinition @DistinctFieldParams -Verbose) 4>&1
                $WithDistinctField  | Should -Be 'Performing the operation "GET /api/reporting/definitions/foofield" on target "https://foo".'
            }
        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{'Count'=1;'Warnings'=@{};'Definitions'=@{}}
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

               $output = Get-SmaReportingDefinition @GenericParams 
               $output | Should -Be "@{Count=1; Warnings=System.Collections.Hashtable; Definitions=System.Collections.Hashtable}"
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }
        }
    }
} 

