$root = Split-Path (Split-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) -Parent) -Parent

Get-Module KaceSMA | Remove-Module -Force
Import-Module $root\KaceSMA.psd1

Describe 'Get-SmaStartupProgramInventory Unit Tests' -Tags 'Unit' {
    InModuleScope KaceSMA {
        Context 'Backend Calls' {
            Mock New-ApiGetRequest {} -ModuleName KaceSMA
            Mock New-ApiPostRequest {} -ModuleName KaceSMA
            Mock New-ApiPutRequest {} -ModuleName KaceSMA
            Mock New-ApiDeleteRequest {} -ModuleName KaceSMA

            $Server='https://foo'

            $GenericParams = @{
                QueryParameters = "?paging=50"
            }

            $ProgramIDParams = @{
                ProgramID = 1234
            }


            Get-SmaStartupProgramInventory @ProgramIDParams

            It 'should call New-ApiGETRequest' {
                Assert-MockCalled -CommandName New-ApiGETRequest -ModuleName KaceSMA -Times 1
            }

            It 'should not call additional HTTP request methods' {
                $Methods = @('POST','DELETE','PUT')
                Foreach ($Method in $Methods) {
                    Assert-MockCalled -CommandName ("New-Api$Method" + "Request") -ModuleName KaceSMA -Times 0
                }
            }

            It "should call generic endpoint if ProgramID is not defined." {
                $Generic = $(Get-SmaStartupProgramInventory @GenericParams -Verbose) 4>&1
                $Generic  | Should -Be 'Performing the operation "GET /api/inventory/startup_programs" on target "https://foo".'
            }
            It "should call ProgramID $($ProgramIDParams.ProgramID)/changes endpoint" {
                $WithProgramID = $(Get-SmaStartupProgramInventory @ProgramIDParams -Verbose) 4>&1
                $WithProgramID  | Should -Be 'Performing the operation "GET /api/inventory/startup_programs/1234" on target "https://foo".'
            }

        }

        Context 'Function Output' {
            Mock New-ApiGetRequest {
                $MockResponse = [pscustomobject]@{'Count' = 1;'Warnings'=@{};'Tickets'=@{}}
                return $MockResponse
            } -ModuleName KaceSMA

            $ProgramIDParams = @{
                ProgramID = 1234
            }

            It 'should produce [PSCustomObject] output' {
               $output = Get-SmaStartupProgramInventory @ProgramIDParams 
               $output | Should -BeOfType System.Management.Automation.PSCustomObject
            }
        }
    }
} 