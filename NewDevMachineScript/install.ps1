.\InstallWebPlatformInstaller.ps1

# turn off UAC (requires reboot to take effect)
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f

# IIS
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:NetFramework4"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:NetFramework45"
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
