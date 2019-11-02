---
external help file: KaceSMA-help.xml
Module Name: KaceSMA
online version: https://github.com/ArtisanByteCrafter/KaceSMA/blob/master/docs/Connect-SmaServer.md
schema: 2.0.0
---

# Connect-SmaServer

## SYNOPSIS

## SYNTAX

```
Connect-SmaServer [-Server] <String> [-Org] <String> [-Credential] <PSCredential> [<CommonParameters>]
```

## DESCRIPTION
Connect to a SMA server. This command generates an access token to be used during the same session. This token has an expiration of 1 hour, after which you must authenticate again.

## EXAMPLES

### Example 1
```powershell
PS C:\> Connect-SmaServer -Server 'https://kace.example.com' -Org 'Default' -Credential (Get-Credential)

Server            Org      Status    Protocol User
------            ----     ------    -------- ----
kace.example.com  Default  Connected HTTPS    my_user
```

Connects to the default org of a Kace SMA Server.

## PARAMETERS

### -Credential
The credentials of the user authenticating to the SMA Server

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Org
The SMA org to connect to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Server
The FQDN of the appliance. Must begin with `https://`

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.PSCustomObject
## NOTES

## RELATED LINKS
