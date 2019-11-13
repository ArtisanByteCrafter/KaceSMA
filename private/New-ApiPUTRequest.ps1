Function New-ApiPUTRequest {
    param (
        [Parameter(Mandatory)]
        [String]
        $Endpoint,

        [Parameter()]
        $Body
    )

    $APIUrl = "{0}{1}" -f $script:Server, $Endpoint

    $CurrentVersionTls = [Net.ServicePointManager]::SecurityProtocol
    Set-ClientTlsProtocols -ErrorAction Stop

    $IRMSplat = @{
        Uri             = $APIUrl
        Headers         = $script:Headers
        Method          = 'PUT'
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