# .NET - prerequisite for a lot of this stuff
dism /online /enable-feature /featurename:"netfx3"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:NetFramework4"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:NetFramework45"

.\InstallWebPlatformInstaller.ps1

# turn off UAC (requires reboot to take effect)
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f

# IIS and friends
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:IIS7"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:ASPNET"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:BasicAuthentication"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:DefaultDocument"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:DigestAuthentication"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:DirectoryBrowse"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:HTTPErrors"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:HTTPLogging"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:HTTPRedirection"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:IIS7_ExtensionLessURLs"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:IISManagementConsole"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:IPSecurity"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:ISAPIExtensions"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:ISAPIFilters"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:LoggingTools"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:MetabaseAndIIS6Compatibility"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:NETExtensibility"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:RequestFiltering"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:RequestMonitor"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:StaticContent"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:StaticContentCompression"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:Tracing"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:WindowsAuthentication"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:UrlRewrite2"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:MVC4"

cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:WindowsAzureSDK"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:WindowsAzureToolsVS2012"

#msmq
ocsetup MSMQ-Server

# Chocolatey stuff
iex ((new-object net.webclient).DownloadString("http://bit.ly/psChocInstall"))

cinst .\packages.config

.\SetupKeePassHttp.ps1

# fix visual studio menus shouting: http://stackoverflow.com/questions/10859173/how-to-disable-all-caps-menu-titles-in-visual-studio
Set-ItemProperty -Path HKCU:\Software\Microsoft\VisualStudio\11.0\General -Name SuppressUppercaseConversion -Type DWord -Value 1

#get visualhg showing up as a source control option in visual studio: http://www.skimedic.com/blog/post/2012/09/27/Fixing-the-Visual-Studio-2012-and-VisualHG-Installation-Issue.aspx
“C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\devenv” /setup
