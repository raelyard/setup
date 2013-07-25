param ($scriptPath = ".")

start-transcript .\InstallTranscript.txt -append
$scriptPath\install.ps1
stop-transcript

# restart-computer
