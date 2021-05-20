$functionsDirectory = "$powershellDirectory\Functions"
$aliasesDirectory = "$powershellDirectory\Aliases"
$scriptsDirectory = "$powershellDirectory\Scripts"

remove-item alias:curl

# TODO - get this out of profile - load in place from repositories
$coreDirectory = "$codeDirectory\Core"
$coreSolutionFile = "$coreDirectory\Core.sln"

# Add things to path
$personalPowerShellDirectory = "$env:USERPROFILE\My Documents\WindowsPowerShell"
$scripts = "$personalPowerShellDirectory\Scripts"
$env:PATH += ";$scripts;C:\program files\nant-0.85\bin;c:\Program Files\Microsoft FxCop 1.35;C:\Program Files\commandutils;C:\Program Files (x86)\Nano;C:\Program Files (x86)\Windows Resource Kits\Tools;C:\Program Files (x86)\Log Parser 2.2"

echo "setup : $setupDirectory"
echo "ps : $powershellDirectory"
$dotSourceScript = "$powershellDirectory\DotSourceAllScriptsInDirectory.ps1"

. $dotSourceScript

. DotSourceAllScriptsInDirectory $functionsDirectory
. ImportAllAliasesInDirectory $aliasesDirectory
. DotSourceAllScriptsInDirectory $scriptsDirectory
clipx

cd $codeDirectory

"SETUP"
"  user:" + $env:Username
"  scripts:" + $scripts
"_______________________________________________________________________________"
