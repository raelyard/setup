$nservicebusDirectory = "$env:USERPROFILE\AppData\Local\Apps\NServiceBus\v3.3.8\Tools"
function script:returnToSourceQueue{& "$nservicebusDirectory\returntosourcequeue.exe" error all}
