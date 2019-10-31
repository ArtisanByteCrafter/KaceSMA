#
# Module manifest for module 'KaceSMA'
#
# Generated by: Nathaniel Webb
#
# Generated on: 7/18/2018
#

@{

    # Script module or binary module file associated with this manifest.
    RootModule = 'KaceSMA.psm1'

    # Version number of this module.
    ModuleVersion = '2.0.0'

    # Supported PSEditions
    CompatiblePSEditions = @('Windows','Core')

    # ID used to uniquely identify this module
    GUID = 'e1b3190a-7c8e-42e7-92ae-b329a45dd043'

    # Author of this module
    Author = 'Nathaniel Webb'

    # Company or vendor of this module
    # CompanyName = 'Unknown'

    # Copyright statement for this module
    Copyright = '(c) 2019 Nathaniel Webb. All rights reserved.'

    # Description of the functionality provided by this module
    Description = 'A module for interacting with a Quest SMA Appliance and Powershell objects. Requests are submitted to the appliance API and returned as actionable objects. You can run existing scripts, create new script tasks, gather machine and asset information, and much more. New actions are being added as they are developed.'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '5.1'

    # Name of the Windows PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the Windows PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # CLRVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    # RequiredModules = @()

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @(
        'Get-MachineInventory'
        'Get-CurrentUserAccount'
        'Get-UserPermissions'
        'Get-AgentlessInventory'
        'Get-OperatingSystemInventory'
        'Get-MachineProcess'
        'Get-MachineService'
        'Get-SoftwareInventory'
        'Get-StartupProgramInventory'
        'Get-Asset'
        'Get-AssetType'
        'Get-BarcodeAsset'
        'Get-ManagedInstall'
        'Get-ManagedInstallMachineCompatibility'
        'Get-ReportingDefinition'
        'Get-ScriptRunStatus'
        'Get-Script'
        'Get-ScriptDependency'
        'Get-ScriptTask'
        'New-Asset'
        'New-Script'
        'New-ScriptTask'
        'Invoke-Script'
        #'Get-ArchiveAsset' # not working (upstream bug) - https://github.com/ArtisanByteCrafter/KaceSMA/issues/9
        'Set-AssetAsArchived'
        'Get-ServiceDeskQueue'
        'Get-ServiceDeskQueueField'
        'Get-ServiceDeskTicketTemplate'
        'Get-ServiceDeskTicket'
        'New-ServiceDeskTicket'
        'Set-MachineInventory'
        'Set-ServiceDeskTicket'
        'Remove-ServiceDeskTicket'
        'Get-ServiceDeskTicketChanges'
        'Set-Asset'
        'Connect-Server'
        )

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport = @()

    # Variables to export from this module
    VariablesToExport = '*'

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport = @()

    # DSC resources to export from this module
    # DscResourcesToExport = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            # Tags = @()

            # A URL to the license for this module.
            LicenseUri = 'https://github.com/ArtisanByteCrafter/KaceSMA/blob/master/LICENSE'

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/ArtisanByteCrafter/KaceSMA'

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            ReleaseNotes = "
            Be sure to join our community Slack channel (#API) at https://kacecommunity.slack.com
            
            - [Hotfix] Fixed improper http method regression. This would cause POST requests to certain endpoints to fail. (#21)
            "

        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    HelpInfoURI = 'https://github.com/ArtisanByteCrafter/KaceSMA/wiki'

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    DefaultCommandPrefix = 'Sma'

    }
