# Add things to path
$scripts = "$env:USERPROFILE\My Documents\WindowsPowerShell\Scripts"
$env:PATH += ";$scripts;C:\program files\nant-0.85\bin;c:\Program Files\Microsoft FxCop 1.35;C:\Program Files\commandutils;C:\Program Files (x86)\Nano;C:\Program Files (x86)\Windows Resource Kits\Tools;C:\Program Files (x86)\Log Parser 2.2"
 
# Set VS 2010 Vars ##################################################################
# REF: http://blogs.msdn.com/daiken/archive/2006/11/15/configuring-a-visual-studio-2005-environment-for-windows-powershell.aspx
pushd 'C:\Program Files (x86)\Microsoft Visual Studio 11.0\vc'
cmd /c "vcvarsall.bat&set" |
foreach {
 if ($_ -match "=") {
   $v = $_.split("="); set-item -force -path "ENV:\$($v[0])" -value "$($v[1])"
 }
}
popd

# initialize psake ##################################################################
function initialize-psake {Import-Module $psakeDirectory\PSake.psm1;}

# Set Initial directory #############################################################
$codeDirectory = "C:\Code"
$setupDirectory = "$codeDirectory\Setup"
$psakeDirectory = "$setupDirectory\psake"
$coreDirectory = "$codeDirectory\Core"
$coreSolutionFile = "$coreDirectory\Core.sln"

initialize-psake
cd $codeDirectory

# FUNCTIONS ########################################################################
function hgLog{thg log}
function hgPullAndUpdate{hg pull -u --rebase}
function hgPush
{
	hgPullAndUpdate
	hg push --new-branch
}
function hgCommit{thg commit}
function hgCloseBranch($comment)
{
                $branch = hg branch
                if($branch -eq "default")
                {
                                Write-Host "abort: Do not close default branch"
                                return "default"
                }
                Write-Host "attempting to close branch $branch"
                if($comment -eq $Null)
                {
                                $comment = $branch
                                $comment = "Closing branch " + $comment
                }
                Write-Host "hg commit --close-branch -m $comment"
                hg commit --close-branch -m $comment
                Write-Host $branch
                return $branch
}
function hgCloseBranchAndMerge($comment)
{
                $branch = hgCloseBranch($comment)
                if($branch -eq "default")
                {
                                return
                }
                Write-Host "attempting to merge branch $branch"
                Write-Host "updating to default"
                hg up default
                Write-Host "merging branch into default"
                hg merge $branch
                Write-Host "committing merge"
                hg commit -m "Merged branch $branch into default"
}
function codeDirectory{cd $codeDirectory}
function hgCommit{thg commit}
function coreDirectory{cd $coreDirectory}
function openCoreSolution{devenv $coreSolutionFile}
function purgeAllQueues{& "$coreDirectory\build\PurgeAllQueues.ps1"}
function removeAllQueues{& "$coreDirectory\build\RemoveAllQueues.ps1"}

# ALIASES ##########################################################################
set-alias np 'C:\Program Files (x86)\Notepad++\notepad++.exe'
set-alias pull hgPullAndUpdate
set-alias log hgLog
set-alias commit hgCommit
set-alias push hgPush
set-alias close hgCloseBranch
set-alias merge hgCloseBranchAndMerge
set-alias code codeDirectory
set-alias setup setupDirectory
set-alias core coreDirectory
set-alias coresln openCoreSolution
set-alias build invoke-psake
set-alias purge purgeAllQueues
set-alias removeq removeAllQueues

# SCRIPTS ##########################################################################
function Edit-Profile{np $profile}
set-alias pro Edit-Profile
 
function set-title{Param([string] $title); $Host.Ui.RawUi.WindowTitle = $title}
 
# welcome message ###################################################################
# REF: http://www.computerperformance.co.uk/powershell/powershell_profile_ps1.htm
"SETUP"
"  user:" + $env:Username
"  scripts:" + $scripts
"  Imported C:\Program Files\Microsoft Visual Studio 11.0\vc\vcvarsall.bat"
"_______________________________________________________________________________"

