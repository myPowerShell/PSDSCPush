Configuration PSDSCSample            
{            
    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'
    Param([String[]]$ComputerName = "localhost")            
    
    Node $ComputerName            
    {            
        
        Registry DenyWrite
        {
            Ensure    = "Present"
            Key       = "HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}"
            ValueType = 'DWORD'
            ValueName = "Deny_Write"
            ValueData = "1"
      
        }


        Registry DisableBiometrics 
        {
            Ensure = "Present"
            Key = "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics"
            ValueName = "Enabled"
            ValueData = "0"
            ValueType = "Dword"

        } 
       
           
        Script EnableFirewall            
        {            
            
            # Must return a hashtable with at least one key            
            # named 'Result' of type String            
            GetScript = {            
                Return @{            
                    Result = [string]$(netsh advfirewall show allprofiles)            
                }            
            }            
            
            # Must return a boolean: $true or $false            
            TestScript = {            
                If ((netsh advfirewall show allprofiles) -like "State*off*") {            
                    Write-Verbose "One or more firewall profiles are off"            
                    Return $false            
                } Else {            
                    Write-Verbose "All firewall profiles are on"            
                    Return $true            
                }            
            }            
            
            # Returns nothing            
            SetScript = {            
                Write-Verbose "Setting all firewall profiles to on"            
                netsh advfirewall set allprofiles state on            
            }            
        }            
    }            
}            
            
PSDSCSample -ComputerName $ComputerName        
Start-DscConfiguration -Path C:\DSC\Configurations -ComputerName $ComputerName -Wait -Verbose -Force
Set-DscLocalConfigurationManager -Path "C:\DSC\Configurations"          
