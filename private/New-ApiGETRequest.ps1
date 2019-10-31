Function New-ApiGETRequest {
    <#
    .DESCRIPTION
        Performs an authenticated request to the specified endpoint with (optional) parameters
    #>
    [cmdletBinding()]
    param (

        [Parameter(Mandatory)]
        [String]
        $Endpoint,

        [Parameter()]
        [String]
        $QueryParameters
    )

    If ($QueryParameters) {
        $APIUrl = "{0}{1}{2}" -f $script:Server, $Endpoint, $QueryParameters
    }
    Else { $APIUrl = "{0}{1}" -f $script:Server, $Endpoint }

    $CurrentVersionTls = [Net.ServicePointManager]::SecurityProtocol
    Set-ClientTlsProtocols -ErrorAction Stop

    $IRMSplat = @{
        Uri             = $APIUrl
        Headers         = $script:Headers
        Method          = 'GET'
        WebSession      = $script:Session
        UseBasicParsing = $True
    }
    Invoke-RestMethod @IRMSplat

    # Be nice and set session security protocols back to how we found them.
    [Net.ServicePointManager]::SecurityProtocol = $currentVersionTls
}