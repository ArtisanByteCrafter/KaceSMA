---
external help file: KaceSMA-help.xml
Module Name: KaceSMA
online version: https://github.com/ArtisanByteCrafter/KaceSMA/blob/master/docs/Get-SmaReportingDefinition.md
schema: 2.0.0
---

# Get-SmaReportingDefinition

## SYNOPSIS

## SYNTAX

### Id (Default)
```
Get-SmaReportingDefinition [-QueryParameters <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### A
```
Get-SmaReportingDefinition [-Id <Int32>] [-QueryParameters <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### B
```
Get-SmaReportingDefinition [-Name <String>] [-QueryParameters <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### C
```
Get-SmaReportingDefinition [-Field <String>] [-QueryParameters <String>] [-WhatIf] [-Confirm]
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

### -Field
{{ Fill Field Description }}

```yaml
Type: String
Parameter Sets: C
Aliases: DefinitionField

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Id
Specifies the id of the item to query.

```yaml
Type: Int32
Parameter Sets: A
Aliases: DefinitionId

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Name
{{ Fill Name Description }}

```yaml
Type: String
Parameter Sets: B
Aliases: DefinitionName

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### PSCustomObject
## NOTES

## RELATED LINKS
