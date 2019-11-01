---
external help file: KaceSMA-help.xml
Module Name: KaceSMA
online version:
schema: 2.0.0
---

# Get-SmaBarcodeAsset

## SYNOPSIS

## SYNTAX

```
Get-SmaBarcodeAsset [[-BarcodeID] <Int32>] [[-QueryParameters] <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Returns information about an SMA barcode.

## EXAMPLES

### EXAMPLE 1
```
Get-SmaBarcodeAsset
```

Retrieves information about all barcode assets in an org.

### EXAMPLE 2
```
Get-SmaBarcodeAsset -BarcodeId 1
```

Retrieves information a specific barcode within an org.

## PARAMETERS

### -BarcodeID
Specifies the barcode asset to return from the SMA.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -QueryParameters
(Optional) Any additional query parameters to be included.
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
