param ($scriptPath = ".")

# turn off UAC (requires reboot to take effect)
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f

#msmq
ocsetup MSMQ-Server

# IIS and friends
cinst IIS7 -source webpi
cinst ASPNET -source webpi
cinst BasicAuthentication -source webpi
cinst DefaultDocument -source webpi
cinst DigestAuthentication -source webpi
cinst DirectoryBrowse -source webpi
cinst HTTPErrors -source webpi
cinst HTTPLogging -source webpi
cinst HTTPRedirection -source webpi
cinst IIS7_ExtensionLessURLs -source webpi
cinst IISManagementConsole -source webpi
cinst IPSecurity -source webpi
cinst ISAPIExtensions -source webpi
cinst ISAPIFilters -source webpi
cinst LoggingTools -source webpi
cinst MetabaseAndIIS6Compatibility -source webpi
cinst NETExtensibility -source webpi
cinst RequestFiltering -source webpi
cinst RequestMonitor -source webpi
cinst StaticContent -source webpi
cinst StaticContentCompression -source webpi
cinst Tracing -source webpi
cinst WindowsAuthentication -source webpi
cinst UrlRewrite2 -source webpi
cinst MVC4 -source webpi
cinst WindowsAzureSDK -source webpi

# Chocolatey stuff
cinst .\packages.config

cinst WindowsAzureToolsVS2012 -source webpi
.\SetupKeePassHttp.ps1

# fix visual studio menus shouting: http://stackoverflow.com/questions/10859173/how-to-disable-all-caps-menu-titles-in-visual-studio
Set-ItemProperty -Path HKCU:\Software\Microsoft\VisualStudio\11.0\General -Name SuppressUppercaseConversion -Type DWord -Value 1

#get visualhg showing up as a source control option in visual studio: http://www.skimedic.com/blog/post/2012/09/27/Fixing-the-Visual-Studio-2012-and-VisualHG-Installation-Issue.aspx
& "C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\devenv" /setup
