function script:PurgeAllQueues{& "$coreDirectory\build\PurgeAllQueues.ps1"}
function script:RemoveAllQueues{& "$coreDirectory\build\RemoveAllQueues.ps1"}
function script:CreateQueue{ param($qName) & "$coreDirectory\build\CreateMessageQueue.ps1" -qName $qName }
