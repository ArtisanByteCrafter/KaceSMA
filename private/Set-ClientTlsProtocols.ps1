Function Set-ClientTlsProtocols {
    [CmdletBinding()]
    <#
    .SYNOPSIS
        A private utility function to set the available TLS protocols to Tls12 or higher
    
    .EXAMPLE
        PS C:\> Set-ClientTlsProtocols
        Sets the available TLS protocols to Tls12 or higher
    .INPUTS
        None
    .OUTPUTS
        None
    .NOTES
        Useful when setting a minimum version, but not necessarily explicitly declaring all versions.
    #>

    #Dynamically find and include all available protocols 'Tls12' or higher

    
    $AvailableTls = [enum]::GetValues('Net.SecurityProtocolType') | Where-Object { $_ -ge 'Tls12' }
    
    $AvailableTls.ForEach({
        [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor $_
    })
}