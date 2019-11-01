---
external help file: KaceSMA-help.xml
Module Name: KaceSMA
online version:
schema: 2.0.0
---

# Get-SmaManagedInstall

## SYNOPSIS

## SYNTAX

```
Get-SmaManagedInstall [[-ManagedInstallID] <Int32>] [-ListCompatibleMachines] [[-QueryParameters] <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Returns information about SMA managed installs.

## EXAMPLES

### EXAMPLE 1
```
Get-SmaManagedInstall
```

Retrieves information about all managed installs.

### EXAMPLE 2
```
Get-SmaManagedInstall -ManagedInstallID 1234
```

Retrieves information for a managed install with ID 1234.

### EXAMPLE 3
```
Get-SmaManagedInstall -ManagedInstallID 1234 -ListCompatibleMachines
```

Retrieves machines compatible with `-managedinstallID 1234`

## PARAMETERS

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

### -ListCompatibleMachines
Use with -ManagedInstallID if you want to return all machines compatible with a specific managed install.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ManagedInstallID
Specifies the managed install to return from the SMA.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: 0
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
Position: 1
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### PSCustomObject
## NOTES

## RELATED LINKS
