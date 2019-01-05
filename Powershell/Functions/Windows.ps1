function Append-Path
{
    param([string]$newPathEntry)

    if(!$newPathEntry) {
        Throw "newPathEntry is required!"
    }
    $currentPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path.split(';')
    [Collections.Generic.List[String]]$currentPath = $currentPath
    $currentPath.Add($newPathEntry)
	Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value ($currentPath -join ';')
}
