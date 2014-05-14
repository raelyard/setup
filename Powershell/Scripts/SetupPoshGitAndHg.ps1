function isCurrentDirectoryARepository($type) {
 
    if ((Test-Path $type)) {
        return $TRUE
    }
 
    # Test within parent dirs
    $checkIn = (Get-Item .).parent
    while ($checkIn -ne $NULL) {
        $pathToTest = $checkIn.fullname + '/' + $type;
        if ((Test-Path $pathToTest)) {
            return $TRUE
        } else {
            $checkIn = $checkIn.parent
        }
    }
    return $FALSE
}
 
# Posh-Hg and Posh-git prompt
# Change this to point to wherever your two profile scripts are
 
. 'C:\Code\OpenSource\posh-hg\profile.example.ps1'
. 'C:\Code\OpenSource\posh-git\profile.example.ps1'
 
function prompt(){
    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor
 
    Write-Host($pwd) -nonewline
 
    if (isCurrentDirectoryARepository(".git")) {
        # Git Prompt
        $Global:GitStatus = Get-GitStatus
        Write-VcsStatus $GitStatus
    } elseif (isCurrentDirectoryARepository(".hg")) {
        # Mercurial Prompt
        $Global:HgStatus = Get-HgStatus
        Write-VcsStatus $HgStatus
    }
 
    return "> "
}
