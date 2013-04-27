.\InstallSqlServer.cmd

# Chocolatey stuff
iex ((new-object net.webclient).DownloadString("http://bit.ly/psChocInstall"))

cinst .\packages.config

# IIS
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:IIS7"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:ASPNET"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:BasicAuthentication"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:DefaultDocument"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:DigestAuthentication"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:DirectoryBrowse"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:HTTPErrors"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:HTTPLogging"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:HTTPRedirection"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:IIS7_ExtensionLessURLs"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:IISManagementConsole"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:IPSecurity"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:ISAPIExtensions"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:ISAPIFilters"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:LoggingTools"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:MetabaseAndIIS6Compatibility"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:NETExtensibility"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:RequestFiltering"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:RequestMonitor"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:StaticContent"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:StaticContentCompression"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:Tracing"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:WindowsAuthentication"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:UrlRewrite2"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:MVC4"

cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:WindowsAzureSDK"
cmd /C "webpicmd /install /AcceptEula /SuppressReboot /Products:WindowsAzureToolsVS2012"
