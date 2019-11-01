Function New-ScriptTask {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'medium'
    )]
    param(
        [Parameter(Mandatory)]
        [int]
        $ScriptID,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body

    )
    Begin {
        $Endpoint = "/api/script/{0}/task" -f $ScriptID
    }
    Process {
        If ($PSCmdlet.ShouldProcess($Server, "POST $Endpoint")) {
            $newApiPOSTRequestSplat = @{
                Body     = $Body
                Endpoint = $Endpoint
            }
            New-ApiPOSTRequest  @newApiPOSTRequestSplat
        }
    }
    End { }
}