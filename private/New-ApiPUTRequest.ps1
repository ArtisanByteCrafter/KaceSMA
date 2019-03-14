Function New-ApiPUTRequest {
    param (
        [Parameter(Mandatory = $true)]
        [ValidateScript({If ($_ -notmatch "^(http|https)://") {Throw 'Must start with "http://" or "https://"'} Else{$true}} )]
        [String]
        $Server,

        [Parameter(Mandatory = $true)]
        [String]
        $Org,

        [Parameter(Mandatory = $true)]
        [String]
        $Endpoint,

        [Parameter(Mandatory = $True)]
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


    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
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
}