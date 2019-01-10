$profileDirectory = split-path $profile
mkdir -force $profileDirectory
cp ./Microsoft.PowerShell_profile.ps1 $profileDirectory
