# .NET 3.5 - prerequisite for web platform installer
dism /online /enable-feature /featurename:"netfx3"
. iex ((new-object net.webclient).DownloadString("https://bitbucket.org/raelyard/setup/raw/default/NewDevMachineScript/ExtractZip.ps1"))
. iex ((new-object net.webclient).DownloadString("https://bitbucket.org/raelyard/setup/raw/default/NewDevMachineScript/InstallWebPlatformInstaller.ps1"))
InstallWebPlatformInstaller

# .NET - prerequisite for a lot of this stuff
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:NetFramework4"
cmd /C ".\WebPlatformInstaller\webpicmd /install /AcceptEula /SuppressReboot /Products:NetFramework45"

# get Chocolatey installed to now install tortoisehg to be able to get setup repository
# (and later install a whole bunch of stuff)
iex ((new-object net.webclient).DownloadString("http://bit.ly/psChocInstall"))

# installing mercurial so we can clone the repository and get everything
cinst tortoisehg
