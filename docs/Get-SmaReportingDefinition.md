---
external help file: KaceSMA-help.xml
Module Name: KaceSMA
online version: https://github.com/ArtisanByteCrafter/KaceSMA/blob/master/docs/Get-SmaReportingDefinition.md
schema: 2.0.0
---

# Get-SmaReportingDefinition

## SYNOPSIS

## SYNTAX

### DefinitionID (Default)
```
Get-SmaReportingDefinition [-QueryParameters <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### A
```
Get-SmaReportingDefinition [-DefinitionID <Int32>] [-QueryParameters <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### B
```
Get-SmaReportingDefinition [-DefinitionName <String>] [-QueryParameters <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### C
```
Get-SmaReportingDefinition [-DistinctField <String>] [-QueryParameters <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Return reporting definitions

## EXAMPLES

### EXAMPLE 1
```powershell
Get-SmaReportingDefinition
```

Returns all reporting definions

### EXAMPLE 2

```powershell
Get-SmaReportingDefinition -DefinitionID 1234 -QueryParameters "?orgID=1"
```

This will return the reporting definitions for report ID 1234 in ORG 1. Org MUST be specified in the query parameters.

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

### -DefinitionID
Specifies the definition ID to return.

```yaml
Type: Int32
Parameter Sets: A
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefinitionName
Specifies the definition name to return.

```yaml
Type: String
Parameter Sets: B
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DistinctField
Specifies the distinct field to return.

```yaml
Type: String
Parameter Sets: C
Aliases:

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
