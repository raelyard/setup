# getting tortoisehg installed so we can clone repository and execute the scripts to get set up
# iex ((new-object net.webclient).DownloadString("https://bitbucket.org/raelyard/setup/raw/default/NewDevMachineScript/MasterInstall.ps1"))

# trying to refresh path to get hg available to use to now clone repository now that we have tortoisehg installed
[System.Environment]::SetEnvironmentVariable("PATH", [System.Environment]::GetEnvironmentVariable("PATH", "Machine") , "Process")
hg clone https://bitbucket.org/raelyard/setup

cd Setup
.\install.ps1

restart-computer
