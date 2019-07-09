Function New-ApiPUTRequest {
    param (
        [Parameter(Mandatory)]
        [ValidateScript({If ($_ -notmatch "^(http|https)://") {Throw 'Must start with "http://" or "https://"'} Else{$true}} )]
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
        $Body
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
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add('Accept', 'application/json')
    $headers.Add('Content-Type', 'application/json')
    $headers.Add('x-dell-api-version', '8')
    $Request = Invoke-WebRequest -Uri $Uri -Headers $headers -Body $Auth -Method POST -WebSession $session -UseBasicParsing
    $CSRFToken = $request.Headers.'x-dell-csrf-token'
    $headers.Add("x-dell-csrf-token", "$CSRFToken")
    $APIUrl = ("$Server" + "$Endpoint")


    If ($Body) {
        Invoke-RestMethod -Uri $APIUrl -Headers $headers -Method PUT -WebSession $session -UseBasicParsing -Body ($Body | ConvertTo-Json -Compress -Depth 100 -ErrorAction Stop)
    } else {
        Invoke-RestMethod -Uri $APIUrl -Headers $headers -Method PUT -WebSession $session -UseBasicParsing
    }

    # Be nice and set session security protocols back to how we found them.
    [Net.ServicePointManager]::SecurityProtocol = $currentVersionTls
}