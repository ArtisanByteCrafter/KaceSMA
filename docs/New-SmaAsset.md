---
external help file: KaceSMA-help.xml
Module Name: KaceSMA
online version:
schema: 2.0.0
---

# New-SmaAsset

## SYNOPSIS

## SYNTAX

```
New-SmaAsset [-Body] <Hashtable> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new SMA asset.

## EXAMPLES

### EXAMPLE 1
```powershell
PS> $NewAgentAsset = @{
    'Assets' =@(
        @{
        'name'='x2test'
        "asset_type_id" = 5
        'location_id' = 1
        'asset_type_name' = "Computer with Dell Agent"
        }
    )
}

PS> New-SmaAsset -Body $NewAgentAsset
```

Creates a new SMA asset or type 'Computer with Dell Agent'.

## PARAMETERS

### -Body
A hashtable-formatted payload containing the asset information.
See example.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
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
