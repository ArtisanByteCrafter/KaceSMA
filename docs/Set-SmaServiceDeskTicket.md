---
external help file: KaceSMA-help.xml
Module Name: KaceSMA
online version: https://github.com/ArtisanByteCrafter/KaceSMA/blob/master/docs/Set-SmaServiceDeskTicket.md
schema: 2.0.0
---

# Set-SmaServiceDeskTicket

## SYNOPSIS

## SYNTAX

```
Set-SmaServiceDeskTicket -Id <Int32> -Body <Hashtable> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a ticket.

## EXAMPLES

### EXAMPLE 1
```powershell
PS> $processedBody = @{
    'Tickets' = @(
        @{
            status       = 1 # status ID
            'custom_14'  = "my value for custom_14"
            'resolution' = "my resolution"
        }
    )
} 

PS> Set-SmaServiceDeskTicket -TicketID 1234 -Body $TicketUpdate
```

Updates a ticket with ID 1234 with the information provided by the $body.

## PARAMETERS

### -Body
The payload of the update, in hashtable format. See example.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
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
Aliases: TicketId

Required: True
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
