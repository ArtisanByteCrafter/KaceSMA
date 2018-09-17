Function New-ApiPOSTRequest {
    param (
        [Parameter(Mandatory = $true)]
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

        [Parameter(Mandatory = $true)]
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

    Invoke-RestMethod -Uri $APIUrl -Headers $headers -Method POST -WebSession $session -UseBasicParsing -Body $Body
}