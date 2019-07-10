Function New-ApiPOSTRequest {
    param (
        [Parameter(Mandatory)]
        [ValidateScript({
            If ($_ -notmatch "^(http|https)://") {
                Throw 'Must start with "http://" or "https://"'
        } Else{ $true }}
        )]
        [String]
        $Server,

        [Parameter(Mandatory)]
        [String]
        $Org,

        [Parameter(Mandatory)]
        [String]
        $Endpoint,

        [Parameter(Mandatory)]
        [PSCredential]
        $Credential,

        [Parameter()]
        $Body,

        [Parameter()]
        [String]
        $QueryParameters
    )

    $Auth = @{
        'password'         = ($Credential.GetNetworkCredential().password)
        'userName'         = ($Credential.username)
        'organizationName' = $Org
    } | ConvertTo-Json


    # Dynamically find and include all available protocols 'Tls12' or higher.
    # Module requires PS 5.1+ so no error checking should be required.

    $CurrentVersionTls = [Net.ServicePointManager]::SecurityProtocol
    Set-ClientTlsProtocols -ErrorAction Stop

    $Uri = "$Server/ams/shared/api/security/login"
    $session = new-object microsoft.powershell.commands.webrequestsession

    $Headers = @{}
    $headers.Add('Accept', 'application/json')
    $headers.Add('Content-Type', 'application/json')
    $headers.Add('x-dell-api-version', '8')

    $RequestSplat = @{
        Uri             = $Uri
        Headers         = $Headers
        Body            = $Auth
        Method          = 'POST'
        WebSession      = $Session
        UseBasicParsing = $True
    }
    $Request = Invoke-WebRequest @RequestSplat

    $CSRFToken = $Request.Headers.'x-dell-csrf-token'
    $Headers.Add("x-dell-csrf-token", "$CSRFToken")

    If ($QueryParameters) {
        $APIUrl = "{0}{1}{2}" -f $Server,$Endpoint,$QueryParameters
    }
    Else { $APIUrl = "{0}{1}" -f $Server,$Endpoint }

    $IRMSplat = @{
        Uri = $APIUrl
        Headers = $Headers
        Method = 'PUT'
        WebSession = $session
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