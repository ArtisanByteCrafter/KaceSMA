---
external help file: KaceSMA-help.xml
Module Name: KaceSMA
online version: https://github.com/ArtisanByteCrafter/KaceSMA/blob/master/docs/Get-SmaOperatingSystemInventory.md
schema: 2.0.0
---

# Get-SmaOperatingSystemInventory

## SYNOPSIS

## SYNTAX

```
Get-SmaOperatingSystemInventory [-Id <Int32>] [[-QueryParameters] <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Returns information about operating systems for SMA inventory devices, or for  specific inventory device.

## EXAMPLES

### EXAMPLE 1
```
Get-SmaOperatingSystemInventory
```

Retrieves information about all inventory device operating systems.

### EXAMPLE 2
```
Get-SmaOperatingSystemInventory -MachineID 1234
```

Retrieves operating system information for an inventory device with ID 1234.

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

### -Id
Specifies the id of the item to query.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: MachineId

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### PSCustomObject
## NOTES

## RELATED LINKS
