Configuration PSDSCSample01           
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

     # MSOffice Registry Keys that needs to be kept at desired state for app team
        Registry KeepTextUseZeroMaxScanAS 
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Microsoft\Office\16.0\Access Connectivity Engine\Engines\Text"
            ValueName = "UseZeroMaxScanAS"
            ValueData = "One"
            ValueType = "String" 

        }

        Registry KeepTextMaxScanRows 
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Microsoft\Office\16.0\Access Connectivity Engine\Engines\Text"
            ValueName = "MaxScanRows"
            ValueData = "0"
            ValueType = "DWord" 
        }

        Registry KeepTextImportMixedTypes 
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Microsoft\Office\16.0\Access Connectivity Engine\Engines\Text"
            ValueName = "ImportMixedTypes"
            ValueData = "Text"
            ValueType = "String" 

        }
        
        Registry KeepExcelTypeGuessRows 
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Microsoft\Office\16.0\Access Connectivity Engine\Engines\Excel"
            ValueName = "TypeGuessRows"
            ValueData = "0"
            ValueType = "DWord" 
        }

        Registry KeepExcelImportMixedTypes 
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Microsoft\Office\16.0\Access Connectivity Engine\Engines\Excel"
            ValueName = "ImportMixedTypes"
            ValueData = "Text"
            ValueType = "String"

        }

       }
   }


   PSDSCSample01 -output C:\DSC\Configurations
Start-DscConfiguration -path C:\DSC\Configurations -Wait -Force -Verbose

Set-DscLocalConfigurationManager -Path "C:\DSC\Configurations"