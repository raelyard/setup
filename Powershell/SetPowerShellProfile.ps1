$profileDirectory = split-path $profile
mkdir -force $profileDirectory
cp ./Microsoft.PowerShell_profile.ps1 $profileDirectory

mkdir -force $profileDirectory\Modules\psake
cp ..\psake\psake.psm1 $profileDirectory\Modules\psake
