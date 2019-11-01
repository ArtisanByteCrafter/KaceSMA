---
external help file: KaceSMA-help.xml
Module Name: KaceSMA
online version:
schema: 2.0.0
---

# New-SmaScriptTask

## SYNOPSIS

## SYNTAX

```
New-SmaScriptTask [-ScriptID] <Int32> [-Body] <Hashtable> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new script task for a given script ID.
Works with online and offline kscripts.

## EXAMPLES

### EXAMPLE 1
```powershell
$taskparams = @{
'attempts' = 2
    'onFailure' = 'break'
    'onRemediationFailure' = @(
        @{
            'id'= 27 # status ID
            'params'= [ordered]@{
                'type'='status'
                'message'='this is a test message'
            }
        }
    )
}

New-SmaScriptTask -ScriptID 1234 -Body $taskparams
```

Creates a new task for script ID 1234, gives it 2 attempts with a break on failure.
On remediation failure, it logs a status message.

## PARAMETERS

### -ScriptID
The ID of the script who's tasks you'd like information about.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Body
A hashtable-formatted payload with instructions for the task to create.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
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
