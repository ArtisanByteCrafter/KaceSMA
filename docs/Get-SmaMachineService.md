---
external help file: KaceSMA-help.xml
Module Name: KaceSMA
online version:
schema: 2.0.0
---

# Get-SmaMachineService

## SYNOPSIS

## SYNTAX

```
Get-SmaMachineService [[-ServiceID] <String>] [[-QueryParameters] <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Returns information about the SMA inventory services, or a specific service.

## EXAMPLES

### EXAMPLE 1
```
Get-SmaMachineService -Server https://kace.example.com -Org Default -Credential (Get-Credential)
```

Retrieves service information about all inventory devices

### EXAMPLE 2
```
Get-SmaMachineService -Server https://kace.example.com -Org Default -Credential (Get-Credential) -ServiceID 1234
```

Retrieves inventory service information about a service with ID 1234.

## PARAMETERS

### -ServiceID
Specifies the machine service to return from the SMA.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -QueryParameters
Any additional query parameters to be included.
String must begin with a '?' character.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### PSCustomObject
## NOTES

## RELATED LINKS
