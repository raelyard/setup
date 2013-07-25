param ($scriptPath = ".")

start-transcript $scriptPath\InstallTranscript.txt -append
$scriptPath\install.ps1
stop-transcript

# restart-computer
