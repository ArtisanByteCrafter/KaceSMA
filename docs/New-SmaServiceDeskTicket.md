---
external help file: KaceSMA-help.xml
Module Name: KaceSMA
online version:
schema: 2.0.0
---

# New-SmaServiceDeskTicket

## SYNOPSIS

## SYNTAX

```
New-SmaServiceDeskTicket [-Body] <Hashtable> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new SMA service desk ticket.

## EXAMPLES

### EXAMPLE 1
```powershell
PS> $NewTicket = @{
    'Tickets' =@(
            @{
            'title' = 'test-ticket'
            'hd_queue_id' = 7 # queue ID
            'submitter' = 10 # submitter ID
            'category' = 1 # category ID
            "custom_1"    = 'my_custom_text'
            }
        )
}

PS> New-SmaTicket -Body $NewTicket
```

Creates a new SMA ticket for a user with ID of 1234

## PARAMETERS

### -Body
A hashtable-formatted payload containing the ticket information.
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
