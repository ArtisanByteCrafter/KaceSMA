Function New-ApiDELETERequest {
    param (
        [Parameter(Mandatory)]
        [String]
        $Endpoint
    )

    $CurrentVersionTls = [Net.ServicePointManager]::SecurityProtocol
    Set-ClientTlsProtocols -ErrorAction Stop

    $APIUrl = "{0}{1}" -f $script:Server, $Endpoint

    $IRMSplat = @{
        Uri             = $APIUrl
        Headers         = $script:Headers
        Method          = 'DELETE'
        WebSession      = $script:Session
        UseBasicParsing = $true
    }
    Invoke-RestMethod @IRMSplat 

    # Be nice and set session security protocols back to how we found them.
    [Net.ServicePointManager]::SecurityProtocol = $currentVersionTls

}