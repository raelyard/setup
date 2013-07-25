param ($scriptPath = ".")

start-transcript "$scriptPath\InstallTranscript.txt" -append
& "$scriptPath\install.ps1 $scriptPath"
stop-transcript

# restart-computer
