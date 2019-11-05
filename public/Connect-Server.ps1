Function Connect-Server {
    param(
        [Parameter(Mandatory,Position = 0)]
        [ValidateScript( {
                If ($_ -notmatch "^(http|https)://") {
                    Throw 'Must start with "http://" or "https://"'
                }
                Else { $true } }
        )]
        [String]
        $Server,

        [Parameter(Mandatory)]
        [String]
        $Org,

        [Parameter(Mandatory)]
        [PSCredential]
        $Credential

    )

    Begin {
        $Auth = @{
            'password'         = ($Credential.GetNetworkCredential().password)
            'userName'         = ($Credential.username)
            'organizationName' = $Org
        } | ConvertTo-Json

        $script:Server = $Server
        $script:Org = $Org

        # Dynamically find and include all available protocols 'Tls12' or higher.
        # Module requires PS 5.1+ so no error checking should be required.

        $CurrentVersionTls = [Net.ServicePointManager]::SecurityProtocol
        Set-ClientTlsProtocols -ErrorAction Stop
    
        $Uri = "{0}/ams/shared/api/security/login" -f $script:Server

        $script:Session = New-Object Microsoft.PowerShell.Commands.WebRequestSession

        $script:Headers = @{ }
        $script:Headers.Add('Accept', 'application/json')
        $script:Headers.Add('Content-Type', 'application/json')
        $script:Headers.Add('x-dell-api-version', '8')

        $RequestSplat = @{
            Uri             = $Uri
            Headers         = $script:Headers
            Body            = $Auth
            Method          = 'POST'
            WebSession      = $script:Session
            UseBasicParsing = $True
            ErrorAction     = 'Stop'
            TimeoutSec      = 15
        }
        Try {
            $Request = Invoke-WebRequest @RequestSplat
        }
        Catch {

            $writeErrorSplat = @{
                Message  = "Could not authenticate to '$server' in org '$org'. Ensure credentials are correct."
                Category = 'AuthenticationError'
            }
            Write-Error @writeErrorSplat

            break;
        }
        
        $script:CSRFToken = $Request.Headers.'x-dell-csrf-token'
        $script:Headers.Add("x-dell-csrf-token", "$script:CSRFToken")

        # If we received a token, we're authenticated
        If ($script:CSRFToken) {
            [PSCustomObject]@{
                Server   = $script:Server -replace 'https://', ''
                Org      = $Org
                Status   = 'Connected'
                Protocol = if ($Server -match "^(https)://") { 'HTTPS' }else { 'HTTP' }
                User     = $Credential.username
            }
        }
        Else {
            Write-Error "A token from '$Server' could not be retrieved."
        }
    }
    End {
        # Be nice and set session security protocols back to how we found them.
        [Net.ServicePointManager]::SecurityProtocol = $currentVersionTls
    }
}