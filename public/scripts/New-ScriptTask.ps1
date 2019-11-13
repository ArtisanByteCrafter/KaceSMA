Function New-ScriptTask {
    [cmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = 'medium'
    )]
    param(
        [Parameter(
            Mandatory,
            Position = 0,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [Alias('ScriptId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Body

    )
    Begin {
        
    }
    Process {
        $Endpoint = "/api/script/{0}/task" -f $Id

        If ($PSCmdlet.ShouldProcess($Server, "POST $Endpoint")) {
            $newApiPOSTRequestSplat = @{
                Body     = $Body
                Endpoint = $Endpoint
            }
            $Result = New-ApiPOSTRequest  @newApiPOSTRequestSplat
        }
    }
    End {
        $Result
    }
}