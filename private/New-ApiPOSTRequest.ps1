Function New-ApiPOSTRequest {
    param (
        [Parameter(Mandatory)]
        [String]
        $Endpoint,

        [Parameter()]
        $Body,

        [Parameter()]
        [String]
        $QueryParameters
    )

    $CurrentVersionTls = [Net.ServicePointManager]::SecurityProtocol
    Set-ClientTlsProtocols -ErrorAction Stop

    If ($QueryParameters) {
        $APIUrl = "{0}{1}{2}" -f $Server, $Endpoint, $QueryParameters
    }
    Else { $APIUrl = "{0}{1}" -f $Server, $Endpoint }

    $IRMSplat = @{
        Uri             = $APIUrl
        Headers         = $script:Headers
        Method          = 'POST'
        WebSession      = $script:Session
        UseBasicParsing = $true
    }

    If (!($Body)) {
        Invoke-RestMethod @IRMSplat 
    }
    Else {
        $IRMSplat['Body'] = ($Body | ConvertTo-Json -Compress -Depth 100 -ErrorAction Stop)
        Invoke-RestMethod @IRMSplat
    }

    # Be nice and set session security protocols back to how we found them.
    [Net.ServicePointManager]::SecurityProtocol = $currentVersionTls
}