$functionsDirectory = "$powershellDirectory\Functions"
$aliasesDirectory = "$powershellDirectory\Aliases"
$scriptsDirectory = "$powershellDirectory\Scripts"

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

# REF: http://blogs.msdn.com/daiken/archive/2006/11/15/configuring-a-visual-studio-2005-environment-for-windows-powershell.aspx
pushd 'C:\Program Files (x86)\Microsoft Visual Studio 14.0\vc'
cmd /c "vcvarsall.bat&set" |
foreach {
 if ($_ -match "=") {
   $v = $_.split("="); set-item -force -path "ENV:\$($v[0])" -value "$($v[1])"
 }
}
popd

cd $codeDirectory

# REF: http://www.computerperformance.co.uk/powershell/powershell_profile_ps1.htm
"SETUP"
"  user:" + $env:Username
"  scripts:" + $scripts
"  Imported C:\Program Files\Microsoft Visual Studio 14.0\vc\vcvarsall.bat"
"_______________________________________________________________________________"
