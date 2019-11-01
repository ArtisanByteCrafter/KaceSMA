---
external help file: KaceSMA-help.xml
Module Name: KaceSMA
online version:
schema: 2.0.0
---

# Get-SmaServiceDeskTicket

## SYNOPSIS

## SYNTAX

```
Get-SmaServiceDeskTicket [[-TicketID] <Int32>] [[-QueryParameters] <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Returns a list of all tickets.
Sub-entities that can be used on shaping and filtering directives include owner,
submitter, queue, category, priority, status, machine, asset, related_tickets, referring_tickets

## EXAMPLES

### EXAMPLE 1
```powershell
PS> Get-SmaServiceDeskTicket -QueryParameters "?filtering=hd_status.name eq new"
```

Retrieves all tickets with a status of `new`

### EXAMPLE 2
```powershell
Get-SmaServiceDeskTicket -TicketID 1234 -QueryParameters "?shaping= hd_ticket regular,owner limited,submitter limited"
```

Retrieves the standard attributes, plus owner and submitter for ticket ID 1234

## PARAMETERS

### -TicketID
Specifies the ticket to return data for.

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
Any additional query parameters to be included.
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
