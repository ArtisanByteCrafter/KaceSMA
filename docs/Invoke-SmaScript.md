---
external help file: KaceSMA-help.xml
Module Name: KaceSMA
online version:
schema: 2.0.0
---

# Invoke-SmaScript

## SYNOPSIS

## SYNTAX

```
Invoke-SmaScript [-ScriptID] <Int32> [-TargetMachineID] <Array> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Runs a specified script agains a list of given machineIDs

## EXAMPLES

### EXAMPLE 1
```powershell
Invoke-SmaScript -ScriptID 1234 -TargetMachineIDs 5678,2345,4567
```

Runs a script with ID 1234 against machines with IDs 5678,2345,4567

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

### -ScriptID
The ID of the script you'd like to execute.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetMachineID
Specifies the machine ids to target. Multiples should be comma-seperated.

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: True
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

### Int32

## NOTES
output 0=Failure

output non-0 = the given runNow ID

## RELATED LINKS
