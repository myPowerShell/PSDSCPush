<#
.SYNOPSIS
 Keeping select registry key settings from drifting
 Update LCM settings, so the server can self heal drift

.DESCRIPTION
 Using DSC to keep Reg Key Settings

 .NOTE
  File Name : DSC-USGOV_STIGs.ps1
  Author    : 
  Requires  : PowerShell 5
  .EXAMPLE
  ./
#>

  Configuration USGOVSTIGsDscConfiguration 
  {
    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'
    
    Node 'localhost'
    {

    # Configure the LCM
     LocalConfigurationManager
     {
         ActionAfterReboot = "ContinueConfiguration"
         ConfigurationMode = "ApplyAndAutoCorrect"
         ConfigurationModeFrequencyMins = 30
         RefreshFrequencyMins = 30
         RefreshMode = "Push"

    }

     # OS:Win2K16 | USGOV STIGs testing for "IRS Publication 1075"
     # https://www.irs.gov/privacy-disclosure/computer-security-compliance-references-and-related-topics-2022

        # WIN2016-052
        Registry KeepSystemNoConnectedUser
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
            ValueName = "NoConnectedUser"
            ValueData = "3"
            ValueType = "DWord" 

        }

       Registry KeepLsaLimitBlankPasswordUse
        {
            Ensure = "Present"
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
            ValueName = "LimitBlankPasswordUse"
            ValueData = "1"
            ValueType = "DWord" 

        }

        Registry KeepLsaSCENoApplyLegacyAuditPolicy
        {
            Ensure = "Present"
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
            ValueName = "SCENoApplyLegacyAuditPolicy"
            ValueData = "1"
            ValueType = "DWord" 

        }
   
       #USGOV STIGs # WIN2016-058
       Registry LsaCrashOnAuditFail 
        {
            Ensure = "Present"
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
            ValueName = "CrashOnAuditFail"
            ValueData = "1"
            ValueType = "DWord" 

        }

       #USGOV STIGs # WIN2016-058
       Registry WinlogonAllocateDASD 
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
            ValueName = "AllocateDASD"
            ValueData = "1"
            ValueType = "DWord" 

        }

       #USGOV STIGs # WIN2016-073
       Registry WinlogonForceUnlockLogon 
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
            ValueName = "ForceUnlockLogon"
            ValueData = "0"
            ValueType = "DWord" 

        }

       #USGOV STIGs # WIN2016-075
       Registry ParametersRequireSecuritySignature 
        {
            Ensure = "Present"
            Key = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"
            ValueName = "RequireSecuritySignature"
            ValueData = "1"
            ValueType = "DWord" 

        }

       #USGOV STIGs # WIN2016-100
       Registry Lsalmcompatibilitylevel
        {
            Ensure = "Present"
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
            ValueName = "lmcompatibilitylevel"
            ValueData = "5"
            ValueType = "DWord" 

        }

       #USGOV STIGs # WIN2016-105 [Default:NA / Required:1]
       Registry KernelObCaseInsensitive 
        {
            Ensure = "Present"
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SessionManager\Kernel"
            ValueName = "ObCaseInsensitive"
            ValueData = "1"
            ValueType = "DWord" 

        }

       #USGOV STIGs # WIN2016-107 [Default:0 / Required:1]
       Registry SystemFilterAdministratorToken 
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
            ValueName = "FilterAdministratorToken"
            ValueData = "1"
            ValueType = "DWord" 

        }

       #USGOV STIGs # WIN2016-109 [Default:5 / Required:2]
       Registry SystemConsentPromptBehaviorAdmin
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
            ValueName = "ConsentPromptBehaviorAdmin"
            ValueData = "2"
            ValueType = "DWord" 

        }

       #USGOV STIGs # WIN2016-111 [Default:0 / Required:1]
       Registry SystemEnableInstallerDetection
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
            ValueName = "EnableInstallerDetection"
            ValueData = "1"
            ValueType = "DWord" 

        }


       #USGOV STIGs # WIN2016-112 [Default:NA / Required:1]
       Registry SystemEnableSecureUIAPaths
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
            ValueName = "EnableSecureUIAPaths"
            ValueData = "1"
            ValueType = "DWord" 

        }

       #USGOV STIGs # WIN2016-113 [Default:0 / Required:1]
       Registry SystemEnableLUA
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
            ValueName = "EnableLUA"
            ValueData = "1"
            ValueType = "DWord" 

        }

       #USGOV STIGs # WIN2016-114 [Default:0 / Required:1]
       Registry SystemPromptOnSecureDesktop
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
            ValueName = "PromptOnSecureDesktop"
            ValueData = "1"
            ValueType = "DWord" 

        }

       #USGOV STIGs # WIN2016-177 [Default:2 / Required:4]
       Registry mrxsmb10Start
        {
            Ensure = "Present"
            Key = "HKLM:\SYSTEM\CurrentControlSet\Services\mrxsmb10"
            ValueName = "Start"
            ValueData = "4"
            ValueType = "DWord" 

        }

      #USGOV STIGs # WIN2016-179 [Default:NA / Required:0]
       Registry KernelDisableExceptionChainValidation
        {
            Ensure = "Present"
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SessionManager\kernel"
            ValueName = "DisableExceptionChainValidation"
            ValueData = "0"
            ValueType = "DWord" 

        }


      #USGOV STIGs # WIN2016-180 [Default:NA / Required:1]
       Registry MpEngineMpEnablePus
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsDefender\MpEngine"
            ValueName = "MpEnablePus"
            ValueData = "1"
            ValueType = "DWord" 

        }

      #USGOV STIGs # WIN2016-187 [Default:NA / Required:1]
       Registry SessionManagerSafeDllSearchMode
        {
            Ensure = "Present"
            Key = "HKLM:\SYSTEM\CurrentControlSet\Control\SessionManager"
            ValueName = "SafeDllSearchMode"
            ValueData = "1"
            ValueType = "DWord" 

        }

      #USGOV STIGs # WIN2016-192 [Default:NA / Required:0]
       Registry LanmanWorkstationAllowInsecureGuestAuth
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation"
            ValueName = "AllowInsecureGuestAuth"
            ValueData = "0"
            ValueType = "DWord" 

        }

      #USGOV STIGs # WIN2016-193 [Default:NA / Required:0]
       Registry NetworkConnectionsNC_AllowNetBridge_NLA
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkConnections"
            ValueName = "NC_AllowNetBridge_NLA"
            ValueData = "0"
            ValueType = "DWord" 

        }

      #USGOV STIGs # WIN2016-194 [Default:NA / Required:0]
       Registry NetworkConnectionsNC_ShowSharedAccessUI
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkConnections"
            ValueName = "NC_ShowSharedAccessUI"
            ValueData = "0"
            ValueType = "DWord" 

        }

      #USGOV STIGs # WIN2016-195 [Default:NA / Required:1]
       Registry NetworkConnectionsNC_StdDomainUserSetLocation
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkConnections"
            ValueName = "NC_StdDomainUserSetLocation"
            ValueData = "1"
            ValueType = "DWord" 

        }

      #USGOV STIGs # WIN2016-201 [Default:NA / Required:0]
       Registry GPO_NoBackgroundPolicy
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}"
            ValueName = "NoBackgroundPolicy"
            ValueData = "0"
            ValueType = "DWord" 

        }

      #USGOV STIGs # WIN2016-202 [Default:NA / Required:0]
       Registry GPO_NoGPOListChanges
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}"
            ValueName = "NoGPOListChanges"
            ValueData = "0"
            ValueType = "DWord" 

        }

      #USGOV STIGs # WIN2016-204 [Default: / Required:0]
       Registry SystemDisableBkGndGroupPolicy
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
            ValueName = "DisableBkGndGroupPolicy"
            ValueData = "0"
            ValueType = "DWord" 

        }

      #USGOV STIGs # WIN2016-248 [Default: / Required:1]
       Registry TerminalServicesfDisableCdm
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
            ValueName = "fDisableCdm"
            ValueData = "1"
            ValueType = "DWord" 

        }

      #USGOV STIGs # WIN2016-249 [Default: / Required:1]
       Registry TerminalServices
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
            ValueName = "fPromptForPassword"
            ValueData = "1"
            ValueType = "DWord" 

        }

      #USGOV STIGs # WIN2016-254 [Default:NA / Required:1]
       Registry FeedsDisableEnclosureDownload
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Policies\Microsoft\InternetExplorer\Feeds"
            ValueName = "DisableEnclosureDownload"
            ValueData = "1"
            ValueType = "DWord" 

        }

      #USGOV STIGs # WIN2016-255 [Default:NA / Required:0]
       Registry WindowsSearchAllowIndexingEncryptedStoresOrItems
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsSearch"
            ValueName = "AllowIndexingEncryptedStoresOrItems"
            ValueData = "0"
            ValueType = "DWord" 

        }


      #USGOV STIGs # WIN2016-265 [Default: / Required:1]
       Registry SystemEnableSmartScreen
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
            ValueName = "EnableSmartScreen"
            ValueData = "1"
            ValueType = "DWord" 

        }


      #USGOV STIGs # WIN2016-280 [Default: / Required:1]
       Registry AUNoAutoRebootWithLoggedOnUsers
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
            ValueName = "NoAutoRebootWithLoggedOnUsers"
            ValueData = "1"
            ValueType = "DWord" 

        }
   

       }
   }


USGOVSTIGsDscConfiguration -output C:\DSC\USGOVSTIGsConfiguration
Start-DscConfiguration -path C:\DSC\USGOVSTIGsConfiguration -Wait -Force -Verbose

Set-DscLocalConfigurationManager -Path "C:\DSC\USGOVSTIGsConfiguration"


<#
Get-DscLocalConfigurationManager
Get-DscConfiguration
Test-DSCConfiguration
Get-DSCConfigurationStatus
Remove-DSCConfigurationDocument -Stage Current
#>







