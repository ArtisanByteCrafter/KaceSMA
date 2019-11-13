---
external help file: KaceSMA-help.xml
Module Name: KaceSMA
online version: https://github.com/ArtisanByteCrafter/KaceSMA/blob/master/docs/Get-SmaScriptTask.md
schema: 2.0.0
---

# Get-SmaScriptTask

## SYNOPSIS

## SYNTAX

```
Get-SmaScriptTask -Id <Int32> [-OrdinalID <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Returns task information about a specific script.

## EXAMPLES

### EXAMPLE 1
```powershell
PS> Get-SmaScriptTask -ScriptID 1234
```

Retrieves task information about a script with ID 1234.

### EXAMPLE 2
```powershell
PS> Get-SmaScript 1234 | Get-SmaScriptTask
```

Uses pipeline to retrieves task information about a script with ID 1234.

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
Aliases: ScriptId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -OrdinalID
{{ Fill OrdinalID Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: OrderId

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
