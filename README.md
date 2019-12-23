# KaceSMA

[![Build Status](https://artisanbytecrafter.visualstudio.com/KaceSMA/_apis/build/status/ArtisanByteCrafter.KaceSMA?branchName=master)](https://artisanbytecrafter.visualstudio.com/KaceSMA/_build/latest?definitionId=3&branchName=master) [![](https://img.shields.io/powershellgallery/v/KaceSMA.svg?logo=powershell&colorA=1C8FDB&logoColor=ffffff&colorB=145C8B)](https://www.powershellgallery.com/packages/KaceSMA)
 ![](https://img.shields.io/powershellgallery/dt/KaceSMA.svg?logo=powershell&colorA=1C8FDB&logoColor=ffffff&colorB=145C8B)



A Powershell module for administering and interacting with a Quest Systems Management Appliance (SMA) via it's API interface.



### To Install

````powershell
Install-Module KaceSMA
````


### Quickstart

- Import the module
- Authenticate to the appliance
- Perform a request

```powershell
PS> Import-Module KaceSma
PS> Connect-SmaServer -Server 'https://kace.example.com' -Org 'Default' -Credential (Get-Credential)
PS> Get-SmaServiceDeskTicket -Id 1

title       : I want to reset my password
created     : 2019-06-13 09:01:13
modified    : 2019-06-13 09:31:02
id          : 1
hd_queue_id : 10
sla_dates   : {}

```

## FAQ

[Visit the FAQ on the wiki](https://github.com/ArtisanByteCrafter/KaceSMA/wiki/FAQ)

## Questions or comments?

---
Join the community [Slack channel]((https://kacecommunity.slack.com/))  (`#Api`)